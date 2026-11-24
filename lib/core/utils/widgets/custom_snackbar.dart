
import 'package:flutter/material.dart';

class CustomSnackBar {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void info({
    required String? title,
    bool isTop = false,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
    );
  }

  static void success({
    required String? title,
    bool isTop = false,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void danger({
    required String? title,
    bool isTop = false,
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void warning({
    required String? title,
    bool isTop = false,
    Widget icon = const Icon(
      Icons.warning_amber_rounded,
      color: Color(0xffdb7c26),
    ),
  }) {
    _show(
      title: title,
      isTop: isTop,
      backgroundColor: const Color(0xffffe4c3),
      textColor: const Color(0xffdb7c26),
      icon: icon,
    );
  }

  static void _show({
    required String? title,
    required Color backgroundColor,
    required Color textColor,
    bool isTop = false,
    Widget? icon,
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (icon != null) ...[
                icon,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: const Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.up,
          
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: isTop ? 10 : 0,
            bottom: isTop ? 0 : 10,
          ),
        ),
      );
  }
}
