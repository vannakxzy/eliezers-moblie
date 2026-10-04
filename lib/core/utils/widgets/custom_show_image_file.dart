import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../constants/constants.dart';

class CustomCoverBook extends StatelessWidget {
  final File? file;
  final String imageUrl;
  final Function ontapPickImage;
  final Function ontapClearImage;

  const CustomCoverBook(
      {super.key,
      this.file,
      this.imageUrl = '',
      required this.ontapPickImage,
      required this.ontapClearImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontapPickImage();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              height: 110,
              width: 80,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: context.moonColors!.trunks,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(kRadius2),
                image: imageUrl != ''
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover)
                    : file == null
                        ? null
                        : DecorationImage(
                            image: FileImage(file!), fit: BoxFit.cover),
              ),
              child: file == null && imageUrl == ''
                  ? const Icon(MoonIcons.generic_picture_24_light)
                  : const SizedBox.shrink()),
          const Gap(kPadding / 2),
          if (imageUrl != "" || file != null)
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
      ),
    );
  }
}
