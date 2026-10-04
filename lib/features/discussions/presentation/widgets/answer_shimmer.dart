import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';

class AnswerShimmer extends StatelessWidget {
  const AnswerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final kShimmerDecoration = BoxDecoration(
        color: context.moonColors!.beerus.withOpacity(0.4),
        borderRadius: BorderRadius.circular(kRadius2));
    return Container(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          // spacing: 30,
          children: [
            ...List.generate(
              3,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: kShimmerDecoration,
                        width: 40,
                        height: 40,
                      ),
                      kPadding.gap,
                      Expanded(
                        child: Container(
                          decoration: kShimmerDecoration,
                          height: 40,
                        ),
                      )
                    ],
                  ),
                  kPadding.gap,
                  Container(
                    decoration: kShimmerDecoration,
                    height: 100,
                    width: double.infinity,
                  ),
                ],
              ),
            )
          ],
        )
            .animate(
              autoPlay: true,
              onComplete: (controller) => controller.repeat(),
            )
            .shimmer(
              // color: Colors.red,
              duration: 1000.ms,
            ));
  }
}
