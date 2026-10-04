import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/answer_entity.dart';

class AnswerWidget extends StatelessWidget {
  final AnswertEntity answer;
  final Function ontap;
  const AnswerWidget({super.key, required this.answer, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  gradient: answer.is_correct
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
                      color: context.moonColors!.goku),
                )),
            kPadding2.gap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (answer.description.isNotEmpty)
                    Text(
                      answer.description,
                      style: context.moonTypography!.body.text12
                          .copyWith(color: context.moonColors!.trunks),
                    ),
                  Text(
                    answer.date,
                    style: context.moonTypography!.body.text12
                        .copyWith(color: context.moonColors!.beerus),
                  ),
                  kPadding.gap,
                  Row(
                    children: [
                      Text("${answer.count_like} ${t.common.like}",
                          style: context.moonTypography!.body.text12
                              .copyWith(color: context.moonColors!.trunks)),
                      kPadding2.gap,
                      Text("${answer.amount_comments} ${t.common.comment}",
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
