import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../constants/constants.dart';
import 'package:moon_design/moon_design.dart';

class CustomImageFile extends StatelessWidget {
  final File? file;
  final Function ontapPickImage;
  final Function ontapClearImage;

  const CustomImageFile(
      {super.key,
      this.file,
      required this.ontapPickImage,
      required this.ontapClearImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ontapPickImage();
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            constraints: const BoxConstraints(maxWidth: double.infinity),
            decoration: BoxDecoration(
              border: Border.all(color: context.moonColors!.beerus, width: 0.5),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(kRadius2),
            ),
            child: file == null
                ? null
                : ClipRRect(
                    borderRadius: BorderRadius.circular(kRadius2),
                    child: Image.file(
                      file!,
                      fit: BoxFit.cover,
                      height: 100, // Same as Container height
                    ),
                  ),
          ),
        ),
        const Gap(kPadding / 2),
        if (file != null)
          GestureDetector(
            onTap: () {
              ontapClearImage();
            },
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(color: context.moonColors!.trunks),
                shape: BoxShape.circle,
              ),
              child: Icon(MoonIcons.controls_close_24_regular,
                  size: 15, color: context.moonColors!.trunks),
            ),
          ),
      ],
    );
  }
}
