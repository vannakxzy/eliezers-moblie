import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';

class ProFileShimmer extends StatelessWidget {
  const ProFileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final kShimmerDecoration = BoxDecoration(
        color: context.moonColors!.beerus.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4));
    return Column(
      children: [
        Container(
          decoration: kShimmerDecoration,
          width: 100,
          height: 100,
        ),
        kPadding.gap,
        Container(
          decoration: kShimmerDecoration,
          width: double.infinity,
          height: 80,
        ),
        kPadding.gap,
        Container(
          decoration: kShimmerDecoration,
          width: double.infinity,
          height: 80,
        ),
        kPadding.gap,
        Container(
          decoration: kShimmerDecoration,
          width: double.infinity,
          height: 80,
        ),
        kPadding.gap,
        Container(
          decoration: kShimmerDecoration,
          width: double.infinity,
          height: 80,
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
