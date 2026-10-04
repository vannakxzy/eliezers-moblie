import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/icon_constant.dart';
import '../../../core/helper/local_data/storge_local.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';
import '../domain/entities/band_entity.dart';

class MorebandButtomSheet extends StatelessWidget {
  final BandEntity band;
  final ValueChanged<morebandEnum> onTap;
  const MorebandButtomSheet({
    super.key,
    required this.band,
    required this.onTap,
  });

  static Future<void> showBottomSheet(
          BuildContext context, BandEntity band, ValueChanged ontap) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => MorebandButtomSheet(
          band: band,
          onTap: ontap,
        ),
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    final token = LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);

    return SafeArea(
      minimum: const EdgeInsets.all(kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(kPadding),
          BottomSheetListTile(
              leading: const Icon(MiconSend),
              title: t.common.send,
              onTap: (value) => onTap(morebandEnum.share)),
          if (token.isNotEmpty)
            BottomSheetListTile(
                leading: const Icon(MoonIcons.generic_info_24_regular),
                title: t.band.viewbandInfo,
                onTap: (value) => onTap(morebandEnum.viewbandInfo)),
          if (token.isNotEmpty && band.owner.isYour)
            BottomSheetListTile(
                leading: const Icon(MoonIcons.media_tuner_24_regular),
                title: t.band.manageCommmunity,
                onTap: (value) => onTap(morebandEnum.manageCommmunity)),
          if (band.yourRole == "owner")
            BottomSheetListTile(
                backgroundColor: context.moonColors!.jiren.withOpacity(0.2),
                textStyle: context.moonTypography!.body.text16
                    .copyWith(color: context.moonColors!.jiren),
                leading: Icon(MoonIcons.generic_log_out_24_regular,
                    color: context.moonColors!.jiren),
                title: t.band.deleteAndLeaveband,
                onTap: (value) => onTap(morebandEnum.deleteAndLeave)),
          if (token.isNotEmpty &&
              band.yourRole != "owner" &&
              band.status == "active")
            BottomSheetListTile(
                backgroundColor: context.moonColors!.jiren.withOpacity(0.2),
                textStyle: context.moonTypography!.body.text16
                    .copyWith(color: context.moonColors!.jiren),
                leading: Icon(MoonIcons.generic_log_out_24_regular,
                    color: context.moonColors!.jiren),
                title: t.common.leave,
                onTap: (value) => onTap(morebandEnum.leave)),
          kPadding.gap,
          BottomSheetListTile(
            title: t.common.cancel,
          ),
          const Gap(kPadding),
        ],
      ),
    );
  }
}

enum morebandEnum {
  share,
  click,
  viewbandInfo,
  manageCommmunity,
  leave,
  deleteAndLeave,
}
