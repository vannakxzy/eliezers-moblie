import 'package:flutter/material.dart';
import '../../../gen/assets.gen.dart';
import 'package:moon_design/moon_design.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.moonColors!.trunks.withOpacity(0.5), // Top-left color
              context.moonColors!.beerus.withOpacity(0.5) // Bottom-right color
            ],
            stops: [0.0, 1],
          ),
          borderRadius: BorderRadius.circular(33)),
      child: Center(
        child: Image.asset(
          Assets.image.loading.path,
        ),
      ),
    );
  }
}
