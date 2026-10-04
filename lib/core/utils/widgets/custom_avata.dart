import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'package:moon_design/moon_design.dart';

class CustomAvatar extends StatelessWidget {
  final String image;
  final bool isverify;
  final double high;
  final double width;
  final String name;
  final Function? ontapProfile;
  final double radius;
  const CustomAvatar({
    super.key,
    required this.image,
    this.isverify = false,
    this.high = 40,
    this.width = 40,
    this.name = 'NULL',
    this.ontapProfile,
    this.radius = kRadiusMax,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isverify ? high + 5 : high,
      width: isverify ? width + 5 : width,
      child: Stack(
        children: [
          Container(
            height: high,
            width: width,
            decoration: BoxDecoration(
              color: image == ""
                  ? context.moonColors!.beerus.withOpacity(0.5)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(width: 0.5, color: context.moonColors!.beerus),
              image: image.isNotEmpty
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                        image,
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            // child: image == ""
            //     ? Center(
            //         child: Text(
            //           name[0],
            //           style: context.moonTypography!.heading.text16
            //               .copyWith(color: context.moonColors!.trunks),
            //         ),
            //       )
            //     : SizedBox(),
          ),
          if (isverify)
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: context.moonColors!.piccolo,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
