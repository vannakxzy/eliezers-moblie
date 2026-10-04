import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomTagCard extends StatelessWidget {
  final String title;
  final Function? ontap;
  final bool isOnSearch;
  final bool isTheSame;
  const CustomTagCard({
    super.key,
    required this.title,
    this.isOnSearch = true,
    this.isTheSame = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return MoonTag(
      onTap: () {
        if (isOnSearch == true) {
          ontap!();
        }
      },
      decoration: BoxDecoration(
        color: isTheSame == true
            ? context.moonColors!.hit
            : context.moonColors!.beerus,
        borderRadius: BorderRadius.circular(39),
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: context.moonTypography!.body.text12.copyWith(
                  color: isTheSame == true
                      ? context.moonColors!.piccolo
                      : context.moonColors!.trunks)),
          if (isOnSearch != true)
            GestureDetector(
              onTap: () {
                if (ontap != null) {
                  ontap!();
                }
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  height: 15,
                  width: 15,
                  color: Colors.transparent,
                  child: const Icon(Icons.close_rounded, size: 15)),
            )
        ],
      ),
    );
  }
}
