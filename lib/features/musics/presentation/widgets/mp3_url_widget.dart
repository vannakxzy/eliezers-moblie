import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:moon_design/moon_design.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/constants.dart';

class Mp3UrlWidget extends StatefulWidget {
  final String audioUrl;

  const Mp3UrlWidget({
    required this.audioUrl,
    super.key,
  });

  @override
  State<Mp3UrlWidget> createState() => _Mp3UrlWidgetState();
}

class _Mp3UrlWidgetState extends State<Mp3UrlWidget> {
  final AudioPlayer _player = AudioPlayer();
  final Dio _dio = Dio();

  PlayerState _playerState = PlayerState.stopped;

  Duration? _duration;
  Duration _position = Duration.zero;

  Waveform? _waveform;
  File? _audioFile;

  double _waveformProgress = 0;
  bool _isLoadingWaveform = true;
  bool _hasError = false;

  StreamSubscription<WaveformProgress>? _waveformSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<void>? _playerCompleteSubscription;
  StreamSubscription<PlayerState>? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isReady => _audioFile != null;

  double get _progress {
    final duration = _duration;

    if (duration == null || duration.inMilliseconds <= 0) {
      return 0;
    }

    return (_position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '00:00';

    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();

    _initStreams();
    _prepareAudio();
  }

  @override
  void didUpdateWidget(covariant Mp3UrlWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.audioUrl != widget.audioUrl) {
      _resetAudio();
      _prepareAudio();
    }
  }

  // ========================================
  // INITIALIZE PLAYER STREAMS
  // ========================================

  void _initStreams() {
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      if (!mounted) return;

      setState(() {
        _duration = duration;
      });
    });

    _positionSubscription = _player.onPositionChanged.listen((position) {
      if (!mounted) return;

      setState(() {
        _position = position;
      });
    });

    _playerCompleteSubscription = _player.onPlayerComplete.listen((event) {
      if (!mounted) return;

      setState(() {
        _playerState = PlayerState.completed;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        _player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      setState(() {
        _playerState = state;
      });
    });
  }

  // ========================================
  // DOWNLOAD AUDIO FROM SERVER URL
  // ========================================

  Future<void> _prepareAudio() async {
    try {
      if (widget.audioUrl.trim().isEmpty) {
        throw Exception('Audio URL is empty');
      }

      final uri = Uri.tryParse(widget.audioUrl);

      if (uri == null ||
          !uri.hasScheme ||
          (uri.scheme != 'http' && uri.scheme != 'https')) {
        throw Exception('Invalid audio URL');
      }

      final tempDir = await getTemporaryDirectory();

      final fileName = 'audio_${widget.audioUrl.hashCode}.mp3';

      final audioFile = File('${tempDir.path}/$fileName');

      if (!await audioFile.exists() || await audioFile.length() == 0) {
        await _dio.download(
          widget.audioUrl,
          audioFile.path,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            receiveTimeout: const Duration(minutes: 5),
          ),
        );
      }

      if (!mounted) return;

      if (await audioFile.length() == 0) {
        throw Exception('Downloaded audio is empty');
      }

      _audioFile = audioFile;

      // Set local audio source for playback.
      await _player.setSource(
        DeviceFileSource(audioFile.path),
      );

      await _loadPlayerInfo();

      if (!mounted) return;

      setState(() {
        _isLoadingWaveform = true;
        _hasError = false;
      });

      // Generate waveform from downloaded audio.
      await _loadWaveform();
    } catch (e) {
      debugPrint('Prepare audio error: $e');

      if (!mounted) return;

      setState(() {
        _isLoadingWaveform = false;
        _hasError = true;
      });
    }
  }

  // ========================================
  // PLAYER INFORMATION
  // ========================================

  Future<void> _loadPlayerInfo() async {
    try {
      final duration = await _player.getDuration();
      final position = await _player.getCurrentPosition();

      if (!mounted) return;

      setState(() {
        _duration = duration;
        _position = position ?? Duration.zero;
      });
    } catch (e) {
      debugPrint('Player info error: $e');
    }
  }

  // ========================================
  // GENERATE WAVEFORM
  // ========================================

  Future<void> _loadWaveform() async {
    try {
      final audioFile = _audioFile;

      if (audioFile == null || !await audioFile.exists()) {
        throw Exception('Audio file does not exist');
      }

      final directory = await getTemporaryDirectory();

      final waveFile = File(
        '${directory.path}/waveform_${audioFile.path.hashCode}.wave',
      );

      await _waveformSubscription?.cancel();

      _waveformSubscription = JustWaveform.extract(
        audioInFile: audioFile,
        waveOutFile: waveFile,
        zoom: const WaveformZoom.pixelsPerSecond(100),
      ).listen(
        (progress) {
          if (!mounted) return;

          setState(() {
            _waveformProgress = progress.progress;

            if (progress.waveform != null) {
              _waveform = progress.waveform;
              _duration ??= progress.waveform!.duration;
              _isLoadingWaveform = false;
            }
          });
        },
        onError: (error) {
          debugPrint('Waveform error: $error');

          if (!mounted) return;

          setState(() {
            _isLoadingWaveform = false;
          });
        },
        onDone: () {
          if (!mounted) return;

          setState(() {
            _isLoadingWaveform = false;
          });
        },
      );
    } catch (e) {
      debugPrint('Load waveform error: $e');

      if (!mounted) return;

      setState(() {
        _isLoadingWaveform = false;
      });
    }
  }

  // ========================================
  // PLAY AUDIO
  // ========================================

  Future<void> _play() async {
    try {
      if (!_isReady) {
        debugPrint('Audio is not ready yet');
        return;
      }

      if (_playerState == PlayerState.paused) {
        await _player.resume();
      } else {
        if (_playerState == PlayerState.completed ||
            _playerState == PlayerState.stopped) {
          await _player.seek(Duration.zero);
        }

        await _player.play(
          DeviceFileSource(_audioFile!.path),
        );
      }
    } catch (e) {
      debugPrint('Play error: $e');
    }
  }

  // ========================================
  // PAUSE AUDIO
  // ========================================

  Future<void> _pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Pause error: $e');
    }
  }

  // ========================================
  // STOP AUDIO
  // ========================================

  Future<void> _stop() async {
    try {
      await _player.stop();

      if (!mounted) return;

      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    } catch (e) {
      debugPrint('Stop error: $e');
    }
  }

  // ========================================
  // SEEK AUDIO
  // ========================================

  Future<void> _seek(double value) async {
    final duration = _duration;

    if (duration == null) return;

    final position = Duration(
      milliseconds: (value * duration.inMilliseconds).round(),
    );

    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint('Seek error: $e');
    }
  }

  void _seekFromOffset(double dx, double width) {
    if (width <= 0) return;

    final value = (dx / width).clamp(0.0, 1.0);

    unawaited(_seek(value));
  }

  // ========================================
  // RESET AUDIO WHEN URL CHANGES
  // ========================================

  Future<void> _resetAudio() async {
    await _waveformSubscription?.cancel();

    await _player.stop();

    if (!mounted) return;

    setState(() {
      _playerState = PlayerState.stopped;
      _duration = null;
      _position = Duration.zero;
      _waveform = null;
      _audioFile = null;
      _waveformProgress = 0;
      _isLoadingWaveform = true;
      _hasError = false;
    });
  }

  // ========================================
  // DISPOSE
  // ========================================

  @override
  void dispose() {
    _waveformSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();

    _player.dispose();
    _dio.close();

    super.dispose();
  }

  // ========================================
  // BUILD UI
  // ========================================

  @override
  Widget build(BuildContext context) {
    final color = context.moonColors!.bulma;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MoonButton.icon(
                borderRadius: BorderRadius.circular(99),
                iconColor: context.moonColors!.goten,
                backgroundColor: context.moonColors!.bulma,
                padding: EdgeInsets.zero,
                buttonSize: MoonButtonSize.md,
                onTap: _isPlaying ? _pause : _play,
                icon: Icon(
                  _isPlaying
                      ? MoonIcons.media_pause_24_light
                      : MoonIcons.media_play_24_regular,
                ),
              ),
              kPadding.gap,
              Expanded(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: _buildWaveform(color),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _formatDuration(_duration),
                style: context.moonTypography!.heading.text14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========================================
  // WAVEFORM UI
  // ========================================

  Widget _buildWaveform(Color color) {
    if (_hasError) {
      return const Center(
        child: Text('Unable to load audio'),
      );
    }

    if (_isLoadingWaveform) {
      return Center(
        child: Text(
          _audioFile == null
              ? 'Loading audio...'
              : 'Generating waveform ${(_waveformProgress * 100).toInt()}%',
        ),
      );
    }

    if (_waveform == null) {
      return const Center(
        child: Text('Waveform unavailable'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            _seekFromOffset(
              details.localPosition.dx,
              width,
            );
          },
          onHorizontalDragUpdate: (details) {
            _seekFromOffset(
              details.localPosition.dx,
              width,
            );
          },
          child: CustomPaint(
            size: Size(width, 50),
            painter: WaveformPainter(
              waveform: _waveform!,
              progress: _progress,
              activeColor: color,
              inactiveColor: Colors.grey.shade300,
            ),
          ),
        );
      },
    );
  }
}

// ========================================
// WAVEFORM PAINTER
// ========================================

class WaveformPainter extends CustomPainter {
  final Waveform waveform;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  WaveformPainter({
    required this.waveform,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (waveform.length <= 0 || size.width <= 0) {
      return;
    }

    const barWidth = 3.0;
    const gap = 2.0;

    final barCount = (size.width / (barWidth + gap)).floor();

    if (barCount <= 0) return;

    final paint = Paint()
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    final activeBars = (barCount * progress).floor();

    for (int i = 0; i < barCount; i++) {
      final pixelIndex = math.min(
        (i * waveform.length / barCount).floor(),
        waveform.length - 1,
      );

      final minValue = waveform.getPixelMin(pixelIndex);
      final maxValue = waveform.getPixelMax(pixelIndex);

      final top = _normalize(maxValue, size.height);
      final bottom = _normalize(minValue, size.height);

      final x = i * (barWidth + gap) + barWidth / 2;

      paint.color = i < activeBars ? activeColor : inactiveColor;

      canvas.drawLine(
        Offset(x, top),
        Offset(x, bottom),
        paint,
      );
    }
  }

  double _normalize(int sample, double height) {
    if (waveform.flags == 0) {
      final value = 32768 + sample.clamp(-32768, 32767).toDouble();

      return height - 1 - value * height / 65536;
    } else {
      final value = 128 + sample.clamp(-128, 127).toDouble();

      return height - 1 - value * height / 256;
    }
  }

  @override
  bool shouldRepaint(
    covariant WaveformPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress ||
        oldDelegate.waveform != waveform ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}
