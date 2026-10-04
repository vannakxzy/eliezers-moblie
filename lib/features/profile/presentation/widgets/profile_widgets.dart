import 'package:flutter/material.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import 'title_widget.dart';
import '../../../setting/domain/entities/setting_entity.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extension/number_extension.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../apps/page/display_image_page.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileWidget extends StatelessWidget {
  final bool isYour;
  final SettingEntity setting;
  final ProfileEntity profile;

  const ProfileWidget({
    super.key,
    this.isYour = false,
    required this.setting,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Hero(
              tag: "324efeff",
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayImagePage(
                        isYourImage: profile.isYour,
                        tag: "324efeff",
                        imageUrl: profile.profile,
                        report: ReportInput(user_id: profile.id),
                      ),
                    ),
                  );
                },
                child: CustomAvatar(
                  image: profile.profile,
                  high: 70,
                  width: 70,
                ),
              ),
            ),
            kPadding2.gap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kPadding.gap,
                  AppText(
                    profile.name,
                    style: context.moonTypography!.body.text20
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  AppText(
                    profile.bio,
                    style: context.moonTypography!.body.text14,
                  ),
                ],
              ),
            )
          ],
        ),
        if (profile.isYour || !setting.private_account)
          Column(
            children: [
              kPadding.gap,
              TitleWidget(
                title: t.profileInfo.activity,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.moonColors!.beerus,
                    )),
                padding: const EdgeInsets.all(kPadding2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // if (setting.show_answer == true)
                    Column(
                      children: [
                        AppText(
                          "${profile.totalAnswers}",
                          style: context.moonTypography!.body.text20
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppText(t.common.answer,
                            style: context.moonTypography!.body.text12.copyWith(
                                color: context.moonColors!.trunks,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    // if (setting.show_question == true)
                    Column(
                      children: [
                        AppText(
                          profile.totalQuestions.toStringNotNull(),
                          style: context.moonTypography!.body.text20
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppText(t.common.question,
                            style: context.moonTypography!.body.text12.copyWith(
                                color: context.moonColors!.trunks,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          profile.totalFavourites.toStringNotNull(),
                          style: context.moonTypography!.body.text20
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(t.common.like,
                            style: context.moonTypography!.body.text12.copyWith(
                                color: context.moonColors!.trunks,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                    // if (showTrueAnwser)
                    Column(
                      children: [
                        Text(
                          profile.correctAnswers.toStringNotNull(),
                          style: context.moonTypography!.body.text20
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(t.common.trueAnswer,
                            style: context.moonTypography!.body.text12.copyWith(
                                color: context.moonColors!.trunks,
                                fontWeight: FontWeight.w400))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ],
    );
  }
}
