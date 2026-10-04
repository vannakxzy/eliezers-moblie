import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/constants.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: kShimmerDecoration,
              width: 45,
              height: 45,
            ),
            const Gap(kPadding),
            Expanded(
              child: Container(
                decoration: kShimmerDecoration,
                width: double.infinity,
                height: 45,
              ),
            ),
          ],
        ),
        kPadding.gap,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: kShimmerDecoration,
              width: 45,
              height: 45,
            ),
            const Gap(kPadding),
            Expanded(
              child: Container(
                decoration: kShimmerDecoration,
                width: double.infinity,
                height: 45,
              ),
            ),
          ],
        ),
      ],
    )
        .animate(
          autoPlay: true,
          onComplete: (controller) => controller.repeat(),
        )
        .shimmer(
          // color: Colors.red,
          duration: 1000.ms,
        );
  }
}

final kShimmerDecoration = BoxDecoration(
    color: const Color.fromARGB(255, 225, 224, 224),
    borderRadius: BorderRadius.circular(kRadius2));
