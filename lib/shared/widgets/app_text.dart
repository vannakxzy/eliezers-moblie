import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  final String data;

  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  // var strutStyle;
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
    // this.strutStyle,
    // this.textAlign,
    // this.textDirection,
    // this.locale,
    // this.softWrap,
    // this.overflow,
    // this.,
    // this.maxLines,
    // this.semanticsLabel,
    // this.textWidthBasis,
    // this.textHeightBehavior,
    // this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }
    return Text(
      data,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
