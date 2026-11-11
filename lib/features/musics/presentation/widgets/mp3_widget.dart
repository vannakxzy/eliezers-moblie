
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:moon_design/moon_design.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/constants.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final File audioFile;

  const PlayerWidget({
    required this.player,
    required this.audioFile,
    super.key,
  });

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;

  Duration? _duration;
  Duration _position = Duration.zero;

  Waveform? _waveform;

  double _waveformProgress = 0;
  bool _isLoadingWaveform = true;

  StreamSubscription<WaveformProgress>? _waveformSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<void>? _playerCompleteSubscription;
  StreamSubscription<PlayerState>? _playerStateChangeSubscription;

  AudioPlayer get player => widget.player;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String _formatDuration(Duration? duration) {
    if (duration == null) return '00:00';

    final minutes = duration.inMinutes.toString().padLeft(2, '0');

    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  double get _progress {
    final duration = _duration;

    if (duration == null || duration.inMilliseconds <= 0) {
      return 0;
    }

    return (_position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();

    _playerState = player.state;

    _loadPlayerInfo();
    _initStreams();
    _loadWaveform();
  }

  Future<void> _loadPlayerInfo() async {
    try {
      final duration = await player.getDuration();
      final position = await player.getCurrentPosition();

      if (!mounted) return;

      setState(() {
        _duration = duration;
        _position = position ?? Duration.zero;
      });
    } catch (e) {
      debugPrint('Player info error: $e');
    }
  }

  // Generate waveform from MP3 file
  Future<void> _loadWaveform() async {
    try {
      if (!await widget.audioFile.exists()) {
        throw Exception('Audio file does not exist');
      }

      final directory = await getTemporaryDirectory();

      final waveFile = File(
        '${directory.path}/waveform_${widget.audioFile.path.hashCode}.wave',
      );

      _waveformSubscription = JustWaveform.extract(
        audioInFile: widget.audioFile,
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
          debugPrint('Waveform generation error: $error');

          if (mounted) {
            setState(() {
              _isLoadingWaveform = false;
            });
          }
        },
        onDone: () {
          if (mounted) {
            setState(() {
              _isLoadingWaveform = false;
            });
          }
        },
      );
    } catch (e) {
      debugPrint('Load waveform error: $e');

      if (mounted) {
        setState(() {
          _isLoadingWaveform = false;
        });
      }
    }
  }

  // Listen to player streams
  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      if (!mounted) return;

      setState(() {
        _duration = duration;
      });
    });

    _positionSubscription = player.onPositionChanged.listen((position) {
      if (!mounted) return;

      setState(() {
        _position = position;
      });
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      if (!mounted) return;

      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      setState(() {
        _playerState = state;
      });
    });
  }

  // Play audio
  Future<void> _play() async {
    try {
      if (_playerState == PlayerState.paused) {
        await player.resume();
      } else {
        await player.play(
          DeviceFileSource(widget.audioFile.path),
        );
      }
    } catch (e) {
      debugPrint('Play error: $e');
    }
  }

  // Pause audio
  Future<void> _pause() async {
    try {
      await player.pause();
    } catch (e) {
      debugPrint('Pause error: $e');
    }
  }

  // Stop audio
  Future<void> _stop() async {
    try {
      await player.stop();

      if (!mounted) return;

      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    } catch (e) {
      debugPrint('Stop error: $e');
    }
  }

  // Seek audio
  Future<void> _seek(double value) async {
    final duration = _duration;

    if (duration == null) return;

    final position = Duration(
      milliseconds: (value * duration.inMilliseconds).round(),
    );

    try {
      await player.seek(position);
    } catch (e) {
      debugPrint('Seek error: $e');
    }
  }

  void _seekFromOffset(double dx, double width) {
    if (width <= 0) return;

    final value = (dx / width).clamp(0.0, 1.0);

    unawaited(_seek(value));
  }

  @override
  void dispose() {
    _waveformSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();

    // AudioPlayer is owned by the parent.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.moonColors!.bulma;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Waveform
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonButton.icon(
                  borderRadius: BorderRadius.circular(99),
                  iconColor: context.moonColors!.goten,
                  backgroundColor: context.moonColors!.bulma,
                  padding: EdgeInsets.zero,
                  buttonSize: MoonButtonSize.md,
                  onTap: _isPlaying ? _pause : _play,
                  icon: !_isPlaying
                      ? Icon(MoonIcons.media_play_24_regular)
                      : Icon(MoonIcons.media_pause_24_light),
                ),
              ],
            ),
            kPadding.gap,
            Expanded(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: _buildWaveform(color),
              ),
            ),
            Text(
              _formatDuration(_duration),
              style: context.moonTypography!.heading.text14,
            ),
          ],
        ),

        // Controls
      ],
    );
  }

  Widget _buildWaveform(Color color) {
    if (_isLoadingWaveform) {
      return Center(
        child: Text(
          'Generating waveform... '
          '${(_waveformProgress * 100).toInt()}%',
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
            size: Size(width, 80),
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

    final centerY = size.height / 2;

    final paint = Paint()
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    final activeBars = (barCount * progress).floor();

    for (int i = 0; i < barCount; i++) {
      final pixelIndex = math.min(
        (i * waveform.length / barCount).floor(),
        waveform.length - 1,
      );

      // Get actual audio amplitude
      final minValue = waveform.getPixelMin(pixelIndex);
      final maxValue = waveform.getPixelMax(pixelIndex);

      // Convert amplitude to screen coordinates
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

  // Normalize audio amplitude based on waveform format
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
