import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';

class ConfirmDeleteDiscussionAlert extends StatefulWidget {
  const ConfirmDeleteDiscussionAlert({
    super.key,
  });

  static Future<bool> show({
    required BuildContext context,
  }) async =>
      await showDialog(
        context: context,
        builder: (_) => const ConfirmDeleteDiscussionAlert(),
      );

  @override
  State<ConfirmDeleteDiscussionAlert> createState() =>
      _ConfirmDeleteDiscussionAlertState();
}

class _ConfirmDeleteDiscussionAlertState
    extends State<ConfirmDeleteDiscussionAlert> {
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
              t.discussion.deleteTitle,
              style: context.moonTypography!.heading.text16,
            ),
            kPadding.gap,
            Text(
              t.discussion.deteleDes,
              textAlign: TextAlign.center,
              style: context.moonTypography!.body.text14
                  .copyWith(color: context.moonColors!.trunks),
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
