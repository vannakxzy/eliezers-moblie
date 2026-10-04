import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../constants/constants.dart';

class CustomBook extends StatelessWidget {
  final String title;
  final String image;
  final double height;
  final double width;
  final double size;
  final EdgeInsets padding;
  final Color? color;
  const CustomBook({
    super.key,
    this.padding = const EdgeInsets.only(left: 12, top: 4),
    this.title = "",
    this.size = 3,
    this.image = "",
    required this.height,
    this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: 0.12,
          child: Container(
            margin: const EdgeInsets.only(left: 12, top: 4),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRadius),
              border: Border.all(color: context.moonColors!.trunks),
            ),
          ),
        ),
        Transform.rotate(
          angle: 0.08,
          child: Container(
            margin: const EdgeInsets.only(left: 6, top: 2),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(kRadius),
              border: Border.all(color: context.moonColors!.trunks),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: kPadding, top: kPadding / 2, right: kPadding),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.moonColors!.goku,
            borderRadius: BorderRadius.circular(kRadius),
            border: Border.all(color: context.moonColors!.trunks),
            image: image.isNotEmpty
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      image,
                    ),
                  )
                : null,
          ),
          child: Text(
            title,
            style: context.moonTypography!.body.text12
                .copyWith(color: context.moonColors!.trunks),
          ),
        ),
      ],
    );
  }
}
