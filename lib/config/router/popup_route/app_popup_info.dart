import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_popup_info.freezed.dart';

/// dialog, bottomsheet
@freezed
class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.customDialog({required Widget child}) =
      _CustomDialog;

  const factory AppPopupInfo.errorDialog({
    @Default('') String? message,
    Function()? onClose,
    Function()? onDismiss,
    String? title,
    String? titleClose,
    bool? canDismiss,
  }) = _ErrorDialog;

  const factory AppPopupInfo.infoDialog({
    @Default('') String? message,
    Function()? onLeftAction,
    Function()? onRightAction,
    String? title,
    String? titleLeft,
    String? titleRight,
    bool? canDismiss,
  }) = _InfoDialog;

  const factory AppPopupInfo.confirmDialog({
    @Default('') String message,
    // Maker<void>? onPressed,
  }) = _ConfirmDialog;

  const factory AppPopupInfo.errorWithRetryDialog({
    @Default('') String message,
    // Maker<void>? onRetryPressed,
  }) = _ErrorWithRetryDialog;

  const factory AppPopupInfo.unAuthenticated({
    required String message,
    required GestureTapCallback onPressedButton,
  }) = _UnAuthenticated;

  const factory AppPopupInfo.addNewQuestionModalBottomSheet() =
      _AddNewQuestionModalBottomSheet;

  const factory AppPopupInfo.modalLogin() = _ModalLogin;
}
