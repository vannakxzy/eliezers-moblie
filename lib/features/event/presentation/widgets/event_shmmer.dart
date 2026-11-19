import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';

class EventShmmer extends StatelessWidget {
  const EventShmmer({super.key});

  @override
  Widget build(BuildContext context) {
    final kShimmerDecoration = BoxDecoration(
        color: context.moonColors!.beerus.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4));
    final kShimmerDecoration2 = BoxDecoration(
        color: context.moonColors!.beerus,
        borderRadius: BorderRadius.circular(4));
    return Column(
      children: [
        kPadding.gap,
        Container(
          decoration: kShimmerDecoration,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height / 4,
          child: Container(
            alignment: Alignment.topRight,
            decoration: kShimmerDecoration2,
            height: 40,
            width: 40,
          ),
        ),
      ],
    );
  }
}
