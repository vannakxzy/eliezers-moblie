import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../features/musics/domain/entities/musics_entity.dart';
import '../../constants/constants.dart';

class CustomeMusicsCard extends StatelessWidget {
  final MusicsEntity music;
  final ValueChanged<bool>? onTapSelect;

  const CustomeMusicsCard({
    super.key,
    required this.music,
    this.onTapSelect,
  });

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      menuItemPadding: EdgeInsets.only(top: kPadding),
      onTap: () {
        onTapSelect?.call(!music.isSelected);
      },
      label: Padding(
        padding: EdgeInsetsGeometry.only(left: kPadding),
        child: Text(music.title),
      ),
      leading: MoonAvatar(
        backgroundImage: CachedNetworkImageProvider(music.cover),
        backgroundColor: context.moonColors!.bulma,
        borderRadius: BorderRadius.circular(kRadius),
        avatarSize: MoonAvatarSize.lg,
        content: music.cover.isNotEmpty
            ? SizedBox()
            : Center(child: Icon(MoonIcons.media_soundwave_24_regular)),
      ),
      content: Padding(
        padding: EdgeInsetsGeometry.only(left: kPadding),
        child: Text(music.artist),
      ),
      trailing: Row(
        children: [
          MoonCheckbox(
            tapAreaSizeValue: 50,
            value: music.isSelected,
            onChanged: (value) {
              if (value != null) {
                debugPrint('Selected: $value');
                onTapSelect?.call(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
