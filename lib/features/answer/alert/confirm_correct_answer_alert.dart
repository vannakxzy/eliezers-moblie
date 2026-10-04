import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';

class ConfirmAnswerAlert extends StatefulWidget {
  final Function ontap;

  final bool isAlreadyCorrect;
  final bool isHaveAnotherCorrect;
  const ConfirmAnswerAlert({
    super.key,
    required this.ontap,
    required this.isAlreadyCorrect,
    required this.isHaveAnotherCorrect,
  });

  static Future<bool> show(
          {required BuildContext context,
          required Function ontap,
          required bool isAlreadyCorrect,
          required bool isHaveAnotherCorrect}) async =>
      await showDialog(
        context: context,
        builder: (_) => ConfirmAnswerAlert(
          ontap: ontap,
          isAlreadyCorrect: isAlreadyCorrect,
          isHaveAnotherCorrect: isHaveAnotherCorrect,
        ),
      );

  @override
  State<ConfirmAnswerAlert> createState() => _ConfirmCorrectAnswerAlertState();
}

class _ConfirmCorrectAnswerAlertState extends State<ConfirmAnswerAlert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConfirmCorrentAnswerWidget(
        ontap: () {},
        isAlreadyCorrect: widget.isAlreadyCorrect,
        isHaveAnotherCorrect: widget.isHaveAnotherCorrect);
  }
}

class ConfirmCorrentAnswerWidget extends StatelessWidget {
  final Function ontap;
  final bool isAlreadyCorrect;
  final bool isHaveAnotherCorrect;
  const ConfirmCorrentAnswerWidget(
      {super.key,
      required this.ontap,
      required this.isAlreadyCorrect,
      required this.isHaveAnotherCorrect});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(kPadding2 * 2),
        padding: const EdgeInsets.symmetric(
            horizontal: kPadding2, vertical: kPadding2),
        decoration: BoxDecoration(
            color: context.moonColors!.gohan,
            borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isAlreadyCorrect
                  ? t.answer.unacceptedTitle
                  : isHaveAnotherCorrect
                      ? t.answer.acceptUpdatedTitle
                      : t.answer.acceptTitle,
              style: context.moonTypography!.heading.text16,
            ),
            kPadding.gap,
            Text(
              isAlreadyCorrect
                  ? t.answer.unacceptedDes
                  : isHaveAnotherCorrect
                      ? t.answer.acceptUpdatedDes
                      : t.answer.acceptDes,
              textAlign: TextAlign.center,
              style: context.moonTypography!.body.text14
                  .copyWith(color: context.moonColors!.trunks),
            ),
            kPadding.gap,
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
                isAlreadyCorrect
                    ? MoonButton(
                        backgroundColor: context.moonColors!.jiren,
                        buttonSize: MoonButtonSize.sm,
                        label: Text(
                          t.common.delete,
                          style: context.moonTypography!.heading.text14
                              .copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(true);
                        })
                    : isHaveAnotherCorrect
                        ? MoonButton(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffE14A0A), // Top-left color
                                  Color(0xffFFE520), // Bottom-right color
                                ],
                                stops: [0.0, 1],
                              ),
                            ),
                            buttonSize: MoonButtonSize.sm,
                            label: Text(
                              t.common.yes,
                              style: context.moonTypography!.heading.text14
                                  .copyWith(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(true);
                            })
                        : MoonButton(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffE14A0A), // Top-left color
                                  Color(0xffFFE520), // Bottom-right color
                                ],
                                stops: [0.0, 1],
                              ),
                            ),
                            buttonSize: MoonButtonSize.sm,
                            label: Text(
                              t.common.yes,
                              style: context.moonTypography!.heading.text14
                                  .copyWith(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(true);
                            })
              ],
            )
          ],
        ),
      ),
    );
  }
}
