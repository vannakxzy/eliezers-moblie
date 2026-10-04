// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../buttomsheet/notification_buttomsheet.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final ValueChanged<NotificationEnum> action;
  const NotificationCard({
    super.key,
    required this.notification,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action(NotificationEnum.tap);
      },
      child: Container(
        padding: EdgeInsets.only(
            left: kPadding,
            bottom: kPadding,
            top: kPadding,
            right: kPadding / 2),
        width: double.infinity,
        decoration: BoxDecoration(
            color: notification.readAt == false &&
                    !notification.type.contains('band')
                ? context.moonColors!.beerus
                : Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                children: [
                  CustomAvatar(
                    image: notification.user!.avatar,
                    high: 40,
                    width: 40,
                    ontapProfile: () {
                      action(NotificationEnum.tapAvatar);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: notification.type == "correct_answer"
                            ? context.moonColors!.piccolo
                            : context.moonColors!.goku,
                        border: Border.all(
                          width: 0.5,
                          color: context.moonColors!.trunks,
                        ),
                      ),
                      child: Center(
                        child: notification.type == "correct_answer"
                            ? const Icon(
                                MiconAnswer,
                                size: 17,
                                color: Colors.white,
                              )
                            : notification.type == "answer"
                                ? const Icon(
                                    MiconAnswer,
                                    size: 17,
                                  )
                                : notification.type.contains('comment')
                                    ? const Icon(
                                        MiconComment,
                                        size: 17,
                                      )
                                    : notification.type.contains('band')
                                        ? const Icon(
                                            MoonIcons.generic_users_24_regular,
                                            size: 17,
                                          )
                                        : const Icon(
                                            MiconLike,
                                            size: 17,
                                          ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            kPadding.gap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: notification.user!.name,
                                style: context.moonTypography!.heading.text16
                                    .copyWith(
                                  color: context.moonColors!.bulma,
                                ),
                              ),
                              TextSpan(
                                text: " ${notification.message}",
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: context.moonColors!.trunks,
                                ),
                              ),
                              if (notification.type.contains('band'))
                                TextSpan(
                                  text: " ${notification.bandName}",
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: context.moonColors!.bulma,
                                  ),
                                ),
                            ])),
                            Text(notification.date,
                                style: context.moonTypography!.body.text12
                                    .copyWith(
                                        color: context.moonColors!.trunks))
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          NotificationButtomsheet.show(context, (value) {
                            action(value);
                            Navigator.pop(context);
                          });
                        },
                        icon: const Icon(
                          MiconMoreHori,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  notification.type.contains('band')
                      ? notification.status == ""
                          ? Padding(
                              padding: const EdgeInsets.only(top: kPadding / 2),
                              child: Row(
                                children: [
                                  MoonButton(
                                    buttonSize: MoonButtonSize.sm,
                                    backgroundColor:
                                        context.moonColors!.piccolo,
                                    label: Text(
                                      t.common.accept,
                                      style: context
                                          .moonTypography!.heading.text16
                                          .copyWith(color: Colors.white),
                                    ),
                                    onTap: () {
                                      action(NotificationEnum.approveband);
                                    },
                                  ),
                                  kPadding.gap,
                                  MoonButton(
                                    buttonSize: MoonButtonSize.sm,
                                    backgroundColor: context.moonColors!.beerus,
                                    label: Text(
                                      t.common.cancel,
                                      style: context
                                          .moonTypography!.heading.text16
                                          .copyWith(
                                              color:
                                                  context.moonColors!.trunks),
                                    ),
                                    onTap: () {
                                      action(NotificationEnum.rejectband);
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Text(t.band.approveMes)
                      : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum NotificationEnum {
  tap,
  delete,
  hideThisType,
  report,
  tapAvatar,
  approveband,
  rejectband
}
