import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
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
      menuItemPadding: EdgeInsets.all(kPadding),
      borderRadius: BorderRadius.circular(kRadius),
      backgroundColor: context.moonColors!.beerus,
      onTap: () {
        ontap();
      },
      leading: MoonAvatar(
        backgroundImage: CachedNetworkImageProvider(entity.cover),
        backgroundColor: context.moonColors!.bulma,
        borderRadius: BorderRadius.circular(kRadius),
        avatarSize: MoonAvatarSize.lg,
        content: entity.cover.isNotEmpty
            ? SizedBox()
            : Center(child: Icon(MoonIcons.media_soundwave_24_regular)),
      ),
      label: Text(
        entity.title,
        style: context.moonTypography!.body.text16,
      ),
      content: Text(entity.artist),
      trailing: MoonButton.icon(
        buttonSize: MoonButtonSize.sm,
        borderRadius: BorderRadius.circular(100),
        backgroundColor: entity.isFavorite
            ? context.moonColors!.piccolo
            : Colors.transparent,
        // borderColor: Colors.red,
        onTap: () {
          clickFavorite();
        },
        icon: Icon(
        
          MoonIcons.generic_heart_24_regular,
          color: context.moonColors!.trunks,
        ),
      ),
    );
  }
}
