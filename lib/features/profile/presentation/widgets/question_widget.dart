import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../home/domain/entities/question_entity.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionEntity question;
  final Function ontap;
  const QuestionWidget(
      {super.key, required this.question, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: question.isTrue
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffE14A0A), // Top-left color
                            Color(0xffFFE520), // Bottom-right color
                          ],
                          stops: [0.0, 1],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.moonColors!.trunks, // Top-left color
                            context.moonColors!.beerus // Bottom-right color
                          ],
                          stops: [0.0, 1],
                        ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    height: 14,
                    width: 14,
                    Assets.svg.star.path,
                    color: context.moonColors!.goku,
                  ),
                )),
            kPadding2.gap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (question.title.isNotEmpty)
                    Text(question.title,
                        style: context.moonTypography!.heading.text14),
                  if (question.description.isNotEmpty)
                    Text(
                      question.description,
                      style: context.moonTypography!.body.text12
                          .copyWith(color: context.moonColors!.trunks),
                    ),
                  Text(
                    question.date,
                    style: context.moonTypography!.body.text12.copyWith(
                        color: context.moonColors!.trunks.withOpacity(0.7)),
                  ),
                  kPadding.gap,
                  Row(
                    children: [
                      Text("${question.amountAnswers} ${t.common.answer}",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks)),
                      kPadding2.gap,
                      Text("${question.amountComments} ${t.common.comment}",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks)),
                      kPadding2.gap,
                      Text("${question.countLike} ${t.common.like}",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
