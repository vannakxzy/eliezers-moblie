import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/extension/string_extension.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  const AppImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmptyOrNull
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            width: 30,
            height: 30,
            placeholder: (_, __) => Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(400),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSecondary,
                  width: 0.5,
                ),
              ),
            ),
            errorWidget: (_, __, error) => Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              height: 30,
            ),
          )
        : const SizedBox.shrink();
  }
}
