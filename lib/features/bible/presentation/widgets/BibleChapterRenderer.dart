import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:moon_design/moon_design.dart';

class BibleChapterRenderer extends StatefulWidget {
  final String html;
  final ValueChanged<int>? onVerseTap;
  final int? selectedVerse;

  const BibleChapterRenderer({
    super.key,
    required this.html,
    this.onVerseTap,
    this.selectedVerse,
  });

  @override
  State<BibleChapterRenderer> createState() => _BibleChapterRendererState();
}

class _BibleChapterRendererState extends State<BibleChapterRenderer> {
  @override
  Widget build(BuildContext context) {
    final updatedHtml = widget.html.replaceFirstMapped(
      RegExp(r'(<span\s+class="yv-v"\s+v=")\d+(")'),
      (match) => '${match.group(1)}66${match.group(2)}',
    );
    return GestureDetector(
      onTap: () {
        setState(() {});
        debugPrint("dddd");
      },
      child: HtmlWidget(
        updatedHtml,
        textStyle: context.moonTypography!.body.text18,
        customWidgetBuilder: (element) {
          return null;
        },
        customStylesBuilder: (element) {
          if (element.localName == 'span' &&
              element.classes.contains('yv-vlbl')) {
            return {
              // 'color': '#000000',
              // 'font-family': 'Garamond',
              'font-size': '40px',
              'padding-right': '10px',
            };
          }
          return null;
        },
      ),
    );
  }
}
