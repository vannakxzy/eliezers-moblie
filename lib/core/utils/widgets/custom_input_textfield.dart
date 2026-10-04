import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../constants/constants.dart';
import '../../extension/string_extension.dart';

class CustomInfoTextfield extends StatelessWidget {
  const CustomInfoTextfield(
      {super.key,
      this.hintText,
      this.labelText,
      this.height,
      this.onChanged,
      this.readOnly = false,
      this.focusNode,
      this.controller});

  final String? hintText;
  final bool readOnly;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? height;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmptyOrNull)
          Padding(
            padding: const EdgeInsets.only(bottom: kPadding / 2),
            child: Text(
              labelText!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        SizedBox(
          height: height ?? kTextTextFieldHeight,
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            expands: height != null,
            maxLines: height != null ? null : 1,
            onTapOutside: (event) {
              // unFocus();
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: context.moonColors!.trunks,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: context.moonColors!.beerus,
              contentPadding: height != null
                  ? const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: kPadding,
                    )
                  : const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}
