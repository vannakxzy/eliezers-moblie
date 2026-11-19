import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../musics/domain/entities/musics_entity.dart';

class MusicListItem extends StatefulWidget {
  final MusicsEntity music;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onPlayTap;

  const MusicListItem({
    super.key,
    required this.music,
    required this.isPlaying,
    required this.onTap,
    required this.onPlayTap,
  });

  @override
  State<MusicListItem> createState() => _MusicListItemState();
}

class _MusicListItemState extends State<MusicListItem> {
  late Future<Duration?> _durationFuture;

  @override
  void initState() {
    super.initState();
    _durationFuture = _getAudioDuration();
  }

  Future<Duration?> _getAudioDuration() async {
    final player = AudioPlayer();

    try {
      await player.setSource(UrlSource(widget.music.audio));
      return await player.getDuration();
    } catch (e) {
      debugPrint('Error getting audio duration: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void didUpdateWidget(covariant MusicListItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.music.audio != widget.music.audio) {
      _durationFuture = _getAudioDuration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      menuItemPadding: EdgeInsets.only(bottom: kPadding2),
      onTap: widget.onTap,
      leading: Padding(
        padding: const EdgeInsets.only(right: kPadding),
        child: MoonAvatar(
          avatarSize: MoonAvatarSize.x2l,
          borderRadius: BorderRadius.circular(kRadius),
          backgroundImage: CachedNetworkImageProvider(widget.music.cover),
          backgroundColor: context.moonColors!.piccolo,
        ),
      ),
      label: Text(widget.music.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.music.artist),
        ],
      ),
      trailing: Row(
        children: [
          FutureBuilder<Duration?>(
            future: _durationFuture,
            builder: (context, snapshot) {
              final duration = snapshot.data;

              return Text(
                duration != null ? _formatDuration(duration) : '--:--',
                style: context.moonTypography!.body.text10
                    .copyWith(color: context.moonColors!.trunks),
              );
            },
          ),
          kPadding.gap,
          MoonButton.icon(
            backgroundColor: context.moonColors!.beerus,
            borderRadius: BorderRadius.circular(kRadiusMax),
            onTap: widget.onPlayTap,
            icon: Icon(
              widget.isPlaying
                  ? MoonIcons.media_pause_24_regular
                  : MoonIcons.media_play_24_regular,
            ),
          ),
        ],
      ),
    );
  }
}
