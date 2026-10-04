import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.title,
    this.onTap,
    this.enable = true,
    this.buttonSize = MoonButtonSize.lg,
    this.isFullWidth = false,
    this.trailing,
    this.leading,
  });

  final String title;
  final GestureTapCallback? onTap;
  final bool enable;
  final MoonButtonSize buttonSize;
  final bool isFullWidth;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return MoonOutlinedButton(
      onTap: enable ? onTap : null,
      buttonSize: buttonSize,
      label: Text(title),
      isFullWidth: isFullWidth,
      trailing: trailing,
      leading: leading,
    );
  }
}
