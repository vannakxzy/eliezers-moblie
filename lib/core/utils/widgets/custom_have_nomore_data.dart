import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';

class CustomHaveNoMoreData extends StatelessWidget {
  const CustomHaveNoMoreData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(kPadding),
      child: Text(t.common.noMoreData),
    );
  }
}
