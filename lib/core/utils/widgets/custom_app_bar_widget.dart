import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool? isClose;
  final Function? ontap;
  const CustomAppBarWidget(
      {super.key,
      required this.title,
      this.isClose = true,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              top: 8,
              child: IconButton(
                onPressed: () {
                  ontap?.call();
                },
                icon: isClose == true
                    ? const Icon(
                        MoonIcons.controls_close_24_regular,
                      )
                    : Icon(
                        Platform.isAndroid
                            ? Icons.arrow_back_rounded
                            : Icons.arrow_back_ios_new_rounded,
                        color: context.moonColors!.bulma,
                      ),
              )),
          Center(
            child: Text(
              title,
              style: context.moonTypography!.heading.text16,
            ),
          )
        ],
      ),
    );
  }
}
