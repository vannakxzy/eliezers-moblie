import 'package:flutter/material.dart';
import '../../helper/fuction.dart';
import 'package:moon_design/moon_design.dart';

class CustomBack extends StatelessWidget {
  final Function? ontap;
  final bool isClose;
  const CustomBack({super.key, this.ontap, this.isClose = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap == null
          ? () {
              unFocus();
              Navigator.pop(context);
            }
          : () {
              ontap?.call();
            },
      child: isClose
          ? const Icon(MoonIcons.controls_close_24_regular)
          : Icon(
              Icons.arrow_back_rounded,
              // Platform.isAndroid
              //     ? Icons.arrow_back_rounded
              //     : Icons.arrow_back_ios_new_rounded,
              size: 26,
            ),
    );
  }
}
