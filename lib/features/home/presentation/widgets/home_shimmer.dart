import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/app_divider.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final kShimmerDecoration = BoxDecoration(
        color: context.moonColors!.beerus.withOpacity(0.4),
        borderRadius: BorderRadius.circular(kRadius2));
    return Container(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  decoration: kShimmerDecoration,
                  width: double.infinity,
                  height: 100,
                ),
                kPadding.gap,
                SizedBox(
                  height: 25,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 1, // 1 row
                    crossAxisSpacing: 8, // Spacing between columns
                    mainAxisSpacing: 8, // Spacing (not needed much since 1 row)
                    childAspectRatio: 0.4,
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    children: List.generate(4, (index) {
                      return Container(
                        decoration: kShimmerDecoration,
                      );
                    }),
                  ),
                ),
                kPadding.gap,
                AppDivider.small(),
                kPadding.gap,
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: kShimmerDecoration,
                  width: double.infinity,
                  height: 250,
                ),
                kPadding.gap,
                SizedBox(
                  height: 25,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 1, // 1 row
                    crossAxisSpacing: 8, // Spacing between columns
                    mainAxisSpacing: 8, // Spacing (not needed much since 1 row)
                    childAspectRatio: 0.4,
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    children: List.generate(2, (index) {
                      return Container(
                        decoration: kShimmerDecoration,
                      );
                    }),
                  ),
                ),
                kPadding.gap,
                AppDivider.small(),
                kPadding.gap,
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: kShimmerDecoration,
                  width: double.infinity,
                  height: 300,
                ),
                kPadding.gap,
                SizedBox(
                  height: 25,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 1, // 1 row
                    crossAxisSpacing: 8, // Spacing between columns
                    mainAxisSpacing: 8, // Spacing (not needed much since 1 row)
                    childAspectRatio: 0.4,
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    children: List.generate(2, (index) {
                      return Container(
                        decoration: kShimmerDecoration,
                      );
                    }),
                  ),
                ),
                kPadding.gap,
                AppDivider.small(),
                kPadding.gap,
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
            ));
  }
}
