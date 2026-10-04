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

class DiscussionCoverWidget extends StatelessWidget {
  final QuestionEntity discussion;
  final Function ontapLike;
  final Function ontapProfile;
  const DiscussionCoverWidget(
      {super.key,
      required this.discussion,
      required this.ontapLike,
      required this.ontapProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (discussion.image.isEmpty)
          Container(
              height: MediaQuery.of(context).padding.top + 40,
              width: double.infinity,
              color: context.moonColors!.frieza),
        if (discussion.image.isNotEmpty || discussion.file != null)
          discussion.file == null
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayImagePage(
                          isYourImage: discussion.isYourQuestion,
                          tag: "f23f23f",
                          report: ReportInput(question_id: discussion.id),
                          imageUrl: discussion.image,
                        ),
                      ),
                    );
                  },
                  child: CustomCachedImageCircle(
                      borderRadius: BorderRadius.zero, image: discussion.image),
                )
              : Image.file(discussion.file!),
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
                    image: discussion.avatar,
                  ),
                  kPadding.gap,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${discussion.name} . ",
                        style: context.moonTypography!.heading.text14
                            .copyWith(color: context.moonColors!.trunks)),
                    TextSpan(
                        text: "${discussion.date} . ",
                        style: context.moonTypography!.heading.text10.copyWith(
                            color: context.moonColors!.trunks.withOpacity(0.7)))
                  ])),
                  kPadding.gap,
                  if (!discussion.isEdited) Text(t.common.editing),
                ]),
              ),
              if (discussion.title.isNotEmpty)
                Text(discussion.title,
                    style: context.moonTypography!.heading.text14),
              if (discussion.description.isNotEmpty)
                Text(discussion.description,
                    style: context.moonTypography!.body.text14
                        .copyWith(color: context.moonColors!.trunks)),
              // kPadding.gap,
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: kPadding, right: kPadding, bottom: kPadding),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Wrap(
              //         runSpacing: kPadding,
              //         spacing: kPadding,
              //         children: discussion.tags
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
                      discussion.is_like
                          ? SvgPicture.asset(Assets.svg.like.path,
                              height: 14, width: 14)
                          : SvgPicture.asset(Assets.svg.unlike.path,
                              color: context.moonColors!.bulma,
                              height: 14,
                              width: 14),
                      Gap(kPadding / 2),
                      Text("${discussion.countLike}",
                          style: context.moonTypography!.body.text12),
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
            "${discussion.amountAnswers} ${t.common.replie}",
            style: context.moonTypography!.heading.text16,
          ),
        ),
      ],
    );
  }
}
