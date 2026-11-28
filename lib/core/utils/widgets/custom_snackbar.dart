
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../../../di/di.dart';
import '../../constants/size_constant.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void info({
    required String? title,
    bool isTop = true,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: const Color(0xFF172B4D),
      accentColor: const Color(0xFF60A5FA),
      icon: Icons.info_rounded,
    );
  }

  static void success({
    required String? title,
    bool isTop = true,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: const Color(0xFF123D32),
      accentColor: const Color(0xFF34D399),
      icon: Icons.check_circle_rounded,
    );
  }

  static void danger({
    required String? title,
    bool isTop = true,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: const Color(0xFF451D25),
      accentColor: const Color(0xFFFB7185),
      icon: Icons.error_rounded,
    );
  }

  static void warning({
    required String? title,
    bool isTop = true,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: const Color(0xFF453016),
      accentColor: const Color(0xFFFBBF24),
      icon: Icons.warning_rounded,
    );
  }

  static void _show({
    required String? title,
    required Color backgroundColor,
    required Color accentColor,
    required IconData icon,
    bool isTop = true,
  }) {
    final message = title?.trim() ?? '';

    if (message.isEmpty) return;

    final navigator = getIt<IAppNavigator>();
    final context = navigator.context;

    if (!context.mounted) return;

    MoonToast.clearToastQueue();

    MoonToast.show(
      context,
      toastAlignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
      isPersistent: false,
      useSafeArea: true,
      displayDuration: const Duration(seconds: 2),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeOutCubic,
      width: MediaQuery.sizeOf(context).width - (kPadding * 2),
      margin: EdgeInsets.only(
        left: kPadding,
        right: kPadding,
        top: isTop ? 12 : 0,
        bottom: isTop ? 0 : 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      borderRadius: BorderRadius.circular(kRadius),
      backgroundColor: backgroundColor,
      label: Text(
        message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
