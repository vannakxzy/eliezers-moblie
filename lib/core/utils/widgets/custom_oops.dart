import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import 'custom_buttom.dart';

class CustomOops extends StatelessWidget {
  final Function ontap;
  const CustomOops({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "OOPS !",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 26, color: Theme.of(context).colorScheme.onPrimary),
        ),
        Text(
          "Something went worng please",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
        ),
        const Gap(10),
        CustomButtom(
            colors: context.moonColors!.piccolo.withOpacity(0.6),
            title: "TRY AGAIN !",
            onTap: () {
              ontap();
            })
      ],
    );
  }
}
