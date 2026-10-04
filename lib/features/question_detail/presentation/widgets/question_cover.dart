import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_cache_image_cricle.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../home/domain/entities/question_entity.dart';

class QuestionCover extends StatelessWidget {
  final QuestionEntity question;
  final Function ontapLike;
  final Function ontapProfile;
  final Function ontapComment;
  const QuestionCover(
      {super.key,
      required this.question,
      required this.ontapLike,
      required this.ontapComment,
      required this.ontapProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.image.isEmpty)
          Container(
              height: MediaQuery.of(context).padding.top + 40,
              width: double.infinity,
              color: context.moonColors!.frieza),
        if (question.image.isNotEmpty || question.file != null)
          question.file == null
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayImagePage(
                          isYourImage: question.isYourQuestion,
                          tag: "f23f23f",
                          report: ReportInput(question_id: question.id),
                          imageUrl: question.image,
                        ),
                      ),
                    );
                  },
                  child: CustomCachedImageCircle(
                      borderRadius: BorderRadius.zero, image: question.image),
                )
              : Image.file(question.file!),
        Container(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  ontapProfile();
                },
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  CustomAvatar(
                    high: 30,
                    width: 30,
                    image: question.avatar,
                  ),
                  kPadding.gap,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${question.name} . ",
                        style: context.moonTypography!.heading.text14
                            .copyWith(color: context.moonColors!.trunks)),
                    TextSpan(
                        text: "${question.date} . ",
                        style: context.moonTypography!.heading.text10.copyWith(
                            color: context.moonColors!.trunks.withOpacity(0.7)))
                  ])),
                  kPadding.gap,
                  if (!question.isEdited) Text(t.common.editing),
                ]),
              ),
              kPadding.gap,
              if (question.title.isNotEmpty)
                Text(question.title,
                    style: context.moonTypography!.heading.text14),
              if (question.description.isNotEmpty)
                Text(question.description,
                    style: context.moonTypography!.body.text14
                        .copyWith(color: context.moonColors!.trunks)),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: kPadding, right: kPadding, bottom: kPadding),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Wrap(
              //         runSpacing: kPadding,
              //         spacing: kPadding,
              //         children: question.tags
              //             .map(
              //               (tag) => CustomTagCard(title: tag.name),
              //             )
              //             .toList(),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  ontapLike();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      question.is_like
                          ? SvgPicture.asset(Assets.svg.like.path,
                              height: 14, width: 14)
                          : SvgPicture.asset(Assets.svg.unlike.path,
                              color: context.moonColors!.bulma,
                              height: 14,
                              width: 14),
                      Gap(kPadding / 2),
                      Text("${question.countLike}",
                          style: context.moonTypography!.body.text12),
                      Gap(kPadding / 2),
                      GestureDetector(
                        onTap: () {
                          ontapComment();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Icon(
                                  size: 18,
                                  MoonIcons.chat_comment_bubble_24_regular),
                              // Gap(kPadding / 2),
                              Text(
                                " ${question.amountComments}",
                                style: context.moonTypography!.body.text12,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // kPadding.gap,
        AppDivider.large(),
        Padding(
          padding: const EdgeInsets.only(left: kPadding, top: kPadding),
          child: Text(
            "${question.amountAnswers} ${t.common.replie}",
            style: context.moonTypography!.heading.text14
                .copyWith(color: context.moonColors!.trunks),
          ),
        ),
      ],
    );
  }
}
