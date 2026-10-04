import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../../core/constants/constants.dart';

class SearchbandItemShimmerWidget extends StatelessWidget {
  const SearchbandItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerDecoration = BoxDecoration(
      color: context.moonColors!.beerus.withOpacity(0.4),
      borderRadius: BorderRadius.circular(kRadius2),
    );

    return Column(
      children: [
        ...List.generate(
          4,
          (index) {
            return MoonMenuItem(
              menuItemCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Container(
                height: 60,
                width: 60,
                decoration: shimmerDecoration,
              ),
              label: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: shimmerDecoration,
                  ),
                  kPadding.gap,
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 80,
                        decoration: shimmerDecoration,
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 14,
                        width: 80,
                        decoration: shimmerDecoration,
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 14,
                        width: 80,
                        decoration: shimmerDecoration,
                      ),
                    ],
                  )
                ],
              ),
            )
                .animate(
                  autoPlay: true,
                  onComplete: (controller) => controller.repeat(),
                )
                .shimmer(duration: 1000.ms);
          },
        )
      ],
    );
  }
}
