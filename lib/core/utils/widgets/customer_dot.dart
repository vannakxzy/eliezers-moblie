import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomerDot extends StatelessWidget {
  const CustomerDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      decoration: ShapeDecoration(
        color: context.moonColors!.beerus,
        shape: MoonSquircleBorder(
          borderRadius: BorderRadius.circular(16).squircleBorderRadius(context),
        ),
      ),
    );
  }
}
