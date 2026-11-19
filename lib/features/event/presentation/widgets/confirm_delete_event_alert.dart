import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../gen/i18n/translations.g.dart';

class ConfirmDeleteEventAlert extends StatefulWidget {
  final bool iswon;
  const ConfirmDeleteEventAlert({
    super.key,
    required this.iswon,
  });

  static Future<bool> show(
    BuildContext context,
    bool iswon,
  ) async =>
      await showDialog(
        context: context,
        builder: (_) => ConfirmDeleteEventAlert(
          iswon: iswon,
        ),
      );

  @override
  State<ConfirmDeleteEventAlert> createState() =>
      _ConfirmDeleteEventAlertState();
}

class _ConfirmDeleteEventAlertState extends State<ConfirmDeleteEventAlert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.moonColors!.frieza,
      insetPadding: const EdgeInsets.symmetric(horizontal: kPadding2 * 2),
      contentPadding: const EdgeInsets.all(kPadding2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius2),
      ),
      content: Container(
        padding: EdgeInsets.all(kPadding),
        color: context.moonColors!.frieza,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            kPadding.gap,
            Text(
              t.event.confirmDelete,
              style: context.moonTypography!.body.text14
                  .copyWith(color: context.moonColors!.trunks),
              textAlign: TextAlign.center,
            ),
            kPadding2.gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonButton(
                    borderRadius: BorderRadius.circular(kRadius),
                    backgroundColor: context.moonColors!.beerus,
                    buttonSize: MoonButtonSize.sm,
                    label: Text(
                      t.common.yes,
                      style: context.moonTypography!.heading.text14
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    }),
                kPadding.gap,
                if (widget.iswon)
                  Column(
                    children: [
                      MoonButton(
                          borderRadius: BorderRadius.circular(kRadius),
                          backgroundColor: context.moonColors!.beerus,
                          buttonSize: MoonButtonSize.sm,
                          label: Text(
                            t.common.cancel,
                            style: context.moonTypography!.heading.text14
                                .copyWith(color: context.moonColors!.bulma),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                      kPadding.gap,
                    ],
                  ),
                if (widget.iswon)
                  MoonButton(
                      borderRadius: BorderRadius.circular(kRadius),
                      backgroundColor: context.moonColors!.beerus,
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
