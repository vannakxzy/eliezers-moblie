import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_text.dart';

// bool _showAlert = true;

class QuestionInfoDialog extends StatelessWidget {
  const QuestionInfoDialog({super.key});

  static void show(BuildContext context) {
    // if (!_showAlert) return;
    // _showAlert = false;
    showDialog(
      context: context,
      builder: (_) => const QuestionInfoDialog().animate().scale(
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: 500.ms,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      // textStyle: const TextStyle(color: Colors.black87, height: 1.5),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            t.post.howTowriteTitle,
            style: context.moonTypography!.heading.text18,
          ),
          const Gap(kPadding),
          AppText(t.post.howTowriteDes,
              style: context.moonTypography!.body.text12),
          const Gap(kPadding),
          AppText(
            t.common.step,
            style: context.moonTypography!.body.text14,
          ),
          const Gap(kPadding / 2),
          AppText(t.post.step1),
          AppText(t.post.step2),
          AppText(t.post.step3),
          AppText(t.post.step4),
          AppText(t.post.step5),
        ],
      ),
    );
  }
}
