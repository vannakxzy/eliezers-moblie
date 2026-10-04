import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../../gen/assets.gen.dart';
import 'package:moon_design/moon_design.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_avata.dart';
import '../../../../core/utils/widgets/custom_cache_image_cricle.dart';
import '../../../setting/bottomsheet/question_detail_buttomsheet.dart';

class QuestionDetailWidget extends StatelessWidget {
  final QuestionEntity question;
  final Function? ontapProfile;
  final Function? ontapLike;
  final Function? ontapShare;
  final bool showOnly;
  final ValueChanged<questionMoreEnum> ontap;
  const QuestionDetailWidget(
      {super.key,
      this.showOnly = true,
      required this.question,
      required this.ontap,
      this.ontapProfile,
      this.ontapLike,
      this.ontapShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.moonColors!.gohan,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (question.image.isEmpty)
              //   Container(
              //       height: MediaQuery.of(context).padding.top + 40,
              //       width: double.infinity,
              //       color: context.moonColors!.piccolo),
              if (question.image.isNotEmpty || question.file != null)
                Column(
                  children: [
                    question.file == null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayImagePage(
                                    isYourImage: question.isYourQuestion,
                                    tag: "f23f23f",
                                    report:
                                        ReportInput(question_id: question.id),
                                    imageUrl: question.image,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: showOnly == true ? "" : "f23f23f",
                              child: CustomCachedImageCircle(
                                  borderRadius: BorderRadius.zero,
                                  image: question.image),
                            ),
                          )
                        : Image.file(question.file!),
                    kPadding.gap,
                  ],
                ),
            ],
          ),
          kPadding.gap,

          // Padding(
          //   padding: const EdgeInsets.only(left: kPadding, bottom: kPadding),
          //   child: Wrap(
          //     runSpacing: kPadding,
          //     spacing: kPadding,
          //     children: question.tags
          //         .map(
          //           (tag) => CustomTagCard(title: tag.name),
          //         )
          //         .toList(),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    ontapProfile!();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(children: [
                      CustomAvatar(
                        high: 30,
                        width: 30,
                        name: question.name,
                        image: question.avatar,
                      ),
                      kPadding.gap,
                      Text("${question.name} . ",
                          style: context.moonTypography!.heading.text14),
                      Text(question.date,
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks)),
                      kPadding.gap,
                      if (!question.isEdited) Text(t.common.editing),
                    ]),
                  ),
                ),
                kPadding.gap,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question.title.isNotEmpty)
                      Text(question.title,
                          style: context.moonTypography!.heading.text14),
                    if (question.description.isNotEmpty)
                      Text(question.description,
                          style: context.moonTypography!.body.text14
                              .copyWith(color: context.moonColors!.trunks)),
                    kPadding.gap,
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ontapLike!();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        question.is_like
                            ? SvgPicture.asset(Assets.svg.like.path,
                                height: 14, width: 14)
                            : SvgPicture.asset(Assets.svg.unlike.path,
                                color:
                                    context.moonColors!.trunks.withOpacity(0.7),
                                height: 14,
                                width: 14),
                        Gap(kPadding / 2),
                        Text("${question.countLike}",
                            style: context.moonTypography!.body.text12)
                      ],
                    ),
                  ),
                ),
                kPadding.gap,
              ],
            ),
          )
        ],
      ),
    );
  }
}
