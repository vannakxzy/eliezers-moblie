import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/extension/string_extension.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class PickImageType extends StatelessWidget {
  const PickImageType._();

  static Future<ImageType?> showBottomSheet(BuildContext context) =>
      showMoonModalBottomSheet(
        context: context,
        builder: (_) => const PickImageType._(),
        // backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum:
          const EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MoonMenuItem(
            horizontalGap: kPadding,
            leading: const Icon(MoonIcons.generic_picture_24_regular),
            label: Text(t.common.gallery.firstUpper()),
            onTap: () => Navigator.pop(context, ImageType.gallery),
          ),
          MoonMenuItem(
            horizontalGap: kPadding,
            leading: const Icon(MoonIcons.media_photo_24_regular),
            label: Text(t.common.camera.firstUpper()),
            onTap: () => Navigator.pop(context, ImageType.camera),
          ),
          MoonMenuItem(
            horizontalGap: kPadding,
            leading: const Icon(MoonIcons.other_smile_24_regular),
            label: Text(t.common.avatar.firstUpper()),
            onTap: () => Navigator.pop(context, ImageType.avatar),
          ),
        ],
      ),
    );
  }
}

enum ImageType { avatar, gallery, camera }
