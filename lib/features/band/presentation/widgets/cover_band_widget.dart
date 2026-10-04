import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/entities/band_entity.dart';

class Coverbandwidget extends StatelessWidget {
  final BandEntity band;
  const Coverbandwidget({super.key, required this.band});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: band.cover.isNotEmpty
            ? Colors.transparent
            : context.moonColors!.piccolo,
        image: DecorationImage(
            image: CachedNetworkImageProvider(band.cover), fit: BoxFit.cover),
      ),
      child: band.cover.isNotEmpty
          ? null
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(kPadding2),
                child: Text(
                  band.name,
                  style: context.moonTypography!.heading.text24
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
    );
  }
}
