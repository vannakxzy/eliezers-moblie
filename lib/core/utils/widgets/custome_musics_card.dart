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
      onTap: () {
        onTapSelect?.call(!music.isSelected);
      },
      label: Text(music.title),
      leading: MoonAvatar(
        backgroundImage: NetworkImage(
             music.cover),
        avatarSize: MoonAvatarSize.lg,
        borderRadius: BorderRadius.circular(kRadiusMax),
      ),
      content: Text(music.artist),
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
