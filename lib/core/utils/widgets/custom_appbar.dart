import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'custom_back.dart';
import 'package:moon_design/moon_design.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final Widget leading;
  final bool isClose;
  const CustomAppBar({
    super.key,
    this.action,
    this.title = "",
    this.isClose = false,
    this.leading = const CustomBack(),
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(30.0), // Adjust the height as needed
      child: AppBar(
        toolbarHeight: preferredSize.height,
        leadingWidth: 40,
        leading: CustomBack(
          isClose: isClose,
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          title,
          style: context.moonTypography!.heading.text20,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kPadding),
            child: action,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
