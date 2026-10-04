import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../extension/string_extension.dart';
import '../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../constants/size_constant.dart';

class CustomCachedImageCircle extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Border? border;

  const CustomCachedImageCircle({
    super.key,
    required this.image,
    this.borderRadius,
    this.height,
    this.border,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return image.isNotEmptyOrNull
        ? ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(kRadiusMax),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: context.moonColors!.beerus, width: 0.5)),
              child: CachedNetworkImage(
                imageUrl: image ?? "",
                height: height,
                width: width,
                fit: BoxFit.cover,
                placeholder: (_, __) => SizedBox(
                  height: height,
                  width: width,
                ),
                errorWidget: (_, __, error) => Container(
                  height: 100,
                  width: width,
                  color: context.moonColors!.beerus, // Error color
                  child: Center(
                      child: Text(
                    t.common.somethingwasWrong,
                  )),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
