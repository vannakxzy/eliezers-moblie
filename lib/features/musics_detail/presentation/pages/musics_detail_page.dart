import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../musics/domain/entities/musics_entity.dart';
import '../bloc/musics_detail_bloc.dart';

@RoutePage()
class MusicsDetailPage extends StatefulWidget {
  final MusicsEntity? entity;
  const MusicsDetailPage({super.key, this.entity});

  @override
  State<MusicsDetailPage> createState() => _MusicsDetailPageState();
}

class _MusicsDetailPageState
    extends BasePageBlocState<MusicsDetailPage, MusicsDetailBloc> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    bloc.add(InitPage(widget.entity!));
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSourceUrl(
        "https://eliezers-events.s3.ap-southeast-1.amazonaws.com/quiz-test-187137.mp3",
      );
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MusicsDetailBloc, MusicsDetailState>(
        builder: (context, state) {
          if (state.musics == null) return Container();
          return Padding(
            padding: const EdgeInsets.all(kPadding2),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.7),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        widget.entity!.cover,
                      ),
                    ),
                  ),
                ),
                kPadding2.gap,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.entity!.title,
                      style: context.moonTypography!.heading.text18,
                    ),
                    Text(
                      "A nice relaxing track for your mood.",
                      style: context.moonTypography!.body.text14,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          bloc.add(ClickFavorite());
                        },
                        icon: Icon(MoonIcons.generic_heart_32_regular,
                            color: state.musics!.isFavorite
                                ? Colors.pink
                                : context.moonColors!.trunks),
                      ),
                      IconButton(
                        onPressed: () {
                          bloc.add(ClickDownload());
                        },
                        icon: const Icon(MoonIcons.generic_download_32_regular),
                      ),
                      IconButton(
                        onPressed: () {
                          bloc.add(ClickShare());
                        },
                        icon: const Icon(
                            MoonIcons.generic_share_arrow_32_regular),
                      ),
                    ],
                  ),
                ),
                PlayerWidget(player: player)
              ],
            ),
          );
        },
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({required this.player, super.key});

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  String _formatDuration(Duration? d) {
    if (d == null) return "00:00";
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String get _durationText => _formatDuration(_duration);
  String get _positionText => _formatDuration(_position);

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();

    _playerState = player.state;
    player.getDuration().then((value) => setState(() => _duration = value));
    player
        .getCurrentPosition()
        .then((value) => setState(() => _position = value));

    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor.primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(_positionText, style: TextStyle(fontSize: 16.0, color: color)),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0.5,
                  activeTrackColor: color,
                  inactiveTrackColor: color.withOpacity(0.3),
                  thumbColor: color,
                  overlayColor: color.withOpacity(0.2),
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 10),
                ),
                child: Slider(
                  value: (_position != null && _duration != null)
                      ? _position!.inMilliseconds / _duration!.inMilliseconds
                      : 0.0,
                  onChanged: (value) {
                    final duration = _duration;
                    if (duration == null) return;

                    final newPos = Duration(
                        milliseconds:
                            (value * duration.inMilliseconds).round());
                    player.seek(newPos);
                    setState(() {
                      _position = newPos;
                    });
                  },
                ),
              ),
            ),
            Text(_durationText, style: TextStyle(fontSize: 16.0, color: color)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: _rewind10s,
                iconSize: 35,
                icon: const Icon(Icons.fast_rewind_rounded),
                color: color),
            IconButton(
              onPressed: _togglePlayPause,
              iconSize: 56,
              icon: Icon(_isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded),
              color: color,
            ),
            IconButton(
                onPressed: _forward10s,
                iconSize: 35,
                icon: const Icon(Icons.fast_forward_rounded),
                color: color),
          ],
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged
        .listen((duration) => setState(() => _duration = duration));
    _positionSubscription =
        player.onPositionChanged.listen((p) => setState(() => _position = p));
    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      if (_position != null && _duration != null && _position! >= _duration!)
        return;
      setState(() {
        _playerState = PlayerState.stopped;
        _position = _duration;
      });
    });
    _playerStateChangeSubscription = player.onPlayerStateChanged
        .listen((state) => setState(() => _playerState = state));
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await player.pause();
      setState(() => _playerState = PlayerState.paused);
    } else {
      await player.resume();
      setState(() => _playerState = PlayerState.playing);
    }
  }

  Future<void> _rewind10s() async {
    final newPos = (_position ?? Duration.zero) - const Duration(seconds: 10);
    await player.seek(newPos > Duration.zero ? newPos : Duration.zero);
  }

  Future<void> _forward10s() async {
    if (_duration == null) return;
    final newPos = (_position ?? Duration.zero) + const Duration(seconds: 10);
    await player.seek(newPos < _duration! ? newPos : _duration!);
  }
}
