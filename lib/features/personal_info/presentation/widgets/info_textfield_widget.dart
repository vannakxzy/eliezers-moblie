import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';

class InfoTextFieldWidget extends StatelessWidget {
  const InfoTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.leading,
    this.enabled = true,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData leading;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: MoonFormTextInput(
        onChanged: onChanged,
        backgroundColor: context.moonColors?.gohan,
        focusNode: !enabled ? FocusNode(skipTraversal: true) : null,
        showCursor: enabled,
        hintText: hintText,
        controller: controller,
        gap: kPadding,
        textInputSize: MoonTextInputSize.xl,
        hasFloatingLabel: true,
        leading: Icon(leading),
      ),
    );
  }
}
