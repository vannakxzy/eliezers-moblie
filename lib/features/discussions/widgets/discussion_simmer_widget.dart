import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';

class DiscussionSimmerWidget extends StatelessWidget {
  const DiscussionSimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final kShimmerDecoration = BoxDecoration(
        color: context.moonColors!.beerus.withOpacity(0.4),
        borderRadius: BorderRadius.circular(kRadius2));
    return Container(
        padding: EdgeInsets.all(kPadding),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(8, (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: kPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 50,
                              decoration: kShimmerDecoration,
                            ),
                            kPadding.gap,
                            Container(
                              height: 40,
                              width: 120,
                              decoration: kShimmerDecoration,
                            ),
                          ],
                        ),
                        kPadding.gap,
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: kShimmerDecoration,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
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
