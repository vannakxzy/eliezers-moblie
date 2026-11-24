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
    return GestureDetector(
      onTap: () {
        setState(() {});
        debugPrint("dddd");
      },
      child: HtmlWidget(
        widget.html,
        textStyle: context.moonTypography!.body.text18,
        customWidgetBuilder: (element) {
          return null;
        },
        customStylesBuilder: (element) {
          if (element.localName == 'span') {
            if (element.classes.contains('yv-vlbl')) {
              return {
                'color': '#FF457b9d',
                'font-size': '30px',
              };
            }
          }
          return null;
        },
      ),
    );
  }
}
