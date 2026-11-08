import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../features/musics/domain/entities/musics_entity.dart';

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
            'https://i.pinimg.com/736x/2e/49/a5/2e49a5b3d05cc4f2643b3e129726ffaa.jpg'),
        avatarSize: MoonAvatarSize.lg,
        borderRadius: BorderRadius.circular(1000),
      ),
      content: Text(""),
      trailing: MoonCheckbox(
        tapAreaSizeValue: 50,
        value: music.isSelected,
        onChanged: (value) {
          if (value != null) {
            debugPrint('Selected: $value');
            onTapSelect?.call(value);
          }
        },
      ),
    );
  }
}
