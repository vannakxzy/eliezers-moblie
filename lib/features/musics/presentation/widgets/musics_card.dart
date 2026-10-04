import 'package:flutter/material.dart';

import '../../domain/entities/musics_entity.dart';
import 'package:moon_design/moon_design.dart';

class MusicsCard extends StatelessWidget {
  final MusicsEntity entity;
  final Function ontap;
  final Function clickFavorite;
  const MusicsCard(
      {super.key,
      required this.entity,
      required this.ontap,
      required this.clickFavorite});

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      onTap: () {
        ontap();
      },
      leading: MoonAvatar(
        backgroundImage: NetworkImage(entity.cover),
        borderRadius: BorderRadius.circular(666),
        avatarSize: MoonAvatarSize.lg,
      ),
      label: Text(
        entity.title,
        style: context.moonTypography!.body.text14,
      ),
      trailing: MoonButton.icon(
        onTap: () {
          clickFavorite();
        },
        icon: Icon(
          MoonIcons.generic_heart_24_regular,
          color: entity.isFavorite ? Colors.pink : context.moonColors!.trunks,
        ),
      ),
    );
  }
}
