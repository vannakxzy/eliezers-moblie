import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/constants.dart';

import '../../../shared/widgets/app_text.dart';

class BottomSheetTitle extends StatelessWidget {
  final Widget? leading;
  final String title;
  final TextStyle? textStyle;
  const BottomSheetTitle({
    super.key,
    required this.title,
    this.textStyle,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPadding2),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      height: kbottomSheetTileTitleHeight,
      width: double.infinity,
      child: Row(
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsets.only(right: kPadding),
              child: leading!,
            ),
          AppText(
            title,
            style: textStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetListTile extends StatelessWidget {
  final String title;
  final Object? callbackValue;
  final Widget? trailing;
  final Widget? leading;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  final void Function(Object? value)? onTap;
  const BottomSheetListTile({
    super.key,
    this.callbackValue,
    required this.title,
    this.trailing,
    this.onTap,
    this.leading,
    this.textStyle,
    this.backgroundColor,
  });

  TextStyle? get _textStyle {
    switch (title.toLowerCase()) {
      case 'cancel':
        return const TextStyle(
          color: AppColor.dangerColor,
          fontWeight: FontWeight.w500,
        );
      default:
    }
    return const TextStyle(
      fontWeight: FontWeight.w500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap?.call(callbackValue);
            return;
          }
          Navigator.pop(context, callbackValue);
        },
        child: Ink(
          height: kbottomSheetTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: kPadding2),
          child: Row(
            children: [
              leading != null
                  ? Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: backgroundColor ?? context.moonColors!.beerus),
                      child: leading)
                  : SizedBox(),
              if (leading != null) Space.kSpace,
              kPadding.gap,
              AppText(
                title,
                style: textStyle ?? _textStyle,
              ),
              if (trailing != null) const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
