import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import 'package:moon_design/moon_design.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({super.key});

  static Future<ImageSource?> showBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => const PickImageBottomSheet(),
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(kPadding2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kPadding2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetTitle(
              // leading: ImageSource.camera.icon,
              title: 'Select Image Source',
            ),
            const AppDivider.normal(),
            BottomSheetListTile(
              leading: ImageSource.camera.icon,
              title: ImageSource.camera.name.firstUpper(),
              callbackValue: ImageSource.camera,
            ),
            const AppDivider.small(),
            BottomSheetListTile(
              leading: ImageSource.gallery.icon,
              title: ImageSource.gallery.name.firstUpper(),
              callbackValue: ImageSource.gallery,
            ),
            const AppDivider.small(),
            BottomSheetListTile(
              leading: Icon(
                Icons.close,
                color: context.moonColors!.jiren,
              ),
              title: 'Cancel',
            ),
          ],
        ),
      ),
    );
  }
}

extension ImageSourceExt on ImageSource {
  Icon get icon {
    switch (this) {
      case ImageSource.camera:
        return const Icon(Icons.camera_alt_outlined);
      case ImageSource.gallery:
        return const Icon(Icons.image_outlined);
    }
  }
}
