import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

class CustomTextfield extends StatelessWidget {
  final bool isBorder;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final bool autofocus;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int? maxLength;
  final Color? color;
  final double radius;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final bool isDense;
  final bool readOnly;

  final bool expands;
  final double? height;

  final Widget? trailing;
  // final EdgeInsetsGeometry? contentPadding;

  const CustomTextfield({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.color,
    this.validator,
    this.labelText,
    this.hintText,
    this.isBorder = true,
    this.autofocus = false,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.hintTextStyle,
    this.maxLines = 1,
    this.maxLength,
    this.radius = 20,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.isDense = true,
    this.textStyle,
    this.textInputAction,
    this.expands = false,
    this.height,
    this.obscureText = false,
    this.trailing,
    this.ontap,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextInputAction? textInputAction;
  final bool obscureText;
  final GestureTapCallback? ontap;

  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty)
          Text(
            labelText!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        const Gap(4),
        // MoonFormTextInput()
        MoonFormTextInput(
          onTap: ontap,
          hintText: hintText,
          textInputSize: MoonTextInputSize.xl,
          focusNode: focusNode,
          autofocus: autofocus,
          controller: controller,
          textInputAction: textInputAction,
          trailing: trailing,
          autovalidateMode: autovalidateMode,

          onChanged: onChanged,
          validator: validator,
          enableSuggestions: textInputType == TextInputType.emailAddress,
          autocorrect: false,
          hasFloatingLabel: true,
          // expands: expands,
          maxLength: maxLength,
          // maxLines: maxLines,
          onSubmitted: onSubmitted,
          keyboardType: textInputType,
          // textAlignVertical: TextAlignVertical.top,
          obscureText: obscureText,

          // decoration: InputDecoration(
          //   isDense: isDense,
          //   contentPadding: expands
          //       ? const EdgeInsets.symmetric(
          //           vertical: kPadding,
          //           horizontal: 14,
          //         )
          //       : kTextFieldPadding,
          //   enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(kRadius),
          //     borderSide: BorderSide(
          //       width: kBorderWidth,
          //       color:
          //           !isBorder ? Colors.transparent : context.moonColors!.trunks,
          //     ),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(kRadius),
          //     borderSide: BorderSide(
          //       color:
          //           !isBorder ? Colors.transparent : context.moonColors!.bulma,
          //       width: kBorderWidth,
          //     ),
          //   ),
          //   errorBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(kRadius),
          //     borderSide: const BorderSide(
          //       width: kBorderWidth,
          //     ),
          //   ),
          //   fillColor: Colors.transparent,
          //   filled: true,
          //   hintText: hintText,
          //   hintStyle: const TextStyle(
          //     fontWeight: FontWeight.w400,
          //     fontSize: 15,
          //   ),
          //   prefixIcon: prefixIcon,
          //   suffixIcon: suffixIcon,
          //   counterText: "",
          // ),
        ),
      ],
    );
  }
}
