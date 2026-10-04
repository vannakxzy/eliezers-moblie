import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';

class DeletebandAlert extends StatefulWidget {
  const DeletebandAlert({
    super.key,
  });

  static Future<bool> show(
    BuildContext context,
  ) async =>
      await showDialog(
        context: context,
        builder: (_) => const DeletebandAlert(),
      );

  @override
  State<DeletebandAlert> createState() => _DeleteAccountAlertState();
}

class _DeleteAccountAlertState extends State<DeletebandAlert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: kPadding2 * 2),
      contentPadding: const EdgeInsets.all(kPadding2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              t.band.deleteband,
              style: context.moonTypography!.heading.text18,
              textAlign: TextAlign.center,
            ),
            kPadding.gap,
            Text(
              t.band.deletebandDes,
              style: context.moonTypography!.body.text16
                  .copyWith(color: context.moonColors!.trunks),
              textAlign: TextAlign.center,
            ),
            kPadding2.gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonButton(
                    backgroundColor: context.moonColors!.trunks,
                    buttonSize: MoonButtonSize.sm,
                    label: Text(
                      t.common.cancel,
                      style: context.moonTypography!.heading.text14
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                kPadding.gap,
                MoonButton(
                    backgroundColor: context.moonColors!.jiren,
                    buttonSize: MoonButtonSize.sm,
                    label: Text(
                      t.common.yes,
                      style: context.moonTypography!.heading.text14
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
