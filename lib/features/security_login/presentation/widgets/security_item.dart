import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/extension/string_extension.dart';

import '../bloc/bloc.dart';

class SecurityItem extends StatelessWidget {
  const SecurityItem({
    super.key,
    this.onTap,
    this.trailing,
    required this.entity,
  });

  final GestureTapCallback? onTap;
  final Widget? trailing;
  final SecurityItemEntity entity;

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      menuItemPadding: EdgeInsets.zero,
      // horizontalGap: 0,
      onTap: onTap,
      leading: MoonAvatar(
        // backgroundColor: context.moonColors!.jiren,
        avatarSize: MoonAvatarSize.md,
        content: Icon(
          entity.leading,
          size: 24,
        ),
      ),
      label: Text(entity.title.firstUpper()),
      // content: Text(entity.description.firstUpper()),
      trailing: trailing ?? Icon(entity.trailing),
    );
  }
}

class SecurityItemEntity {
  final String title;
  final String description;
  final SecurityLoginEvent? event;
  final IconData? leading;
  final IconData? trailing;

  SecurityItemEntity({
    required this.title,
    required this.description,
    this.event,
    this.leading,
    this.trailing,
  });
}
