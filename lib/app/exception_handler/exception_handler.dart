import 'package:dio/dio.dart';

import '../../config/router/popup_route/app_popup_info.dart';
import '../../gen/i18n/translations.g.dart';
import '../base/navigation/app_navigator.dart';
import 'app_exception.dart';

class ExceptionHandler {
  const ExceptionHandler({
    required this.navigator,
  });

  final IAppNavigator navigator;

  Future<void> handleException(
    Exception exception,
    String? commonExceptionMessage,
  ) async {
    if (exception is DioException) {
      return await _showErrorDialog(
        title: t.common.somethingwasWrong,
        message: commonExceptionMessage ?? exception.response?.data['message'],
      );
    }

    if (exception is ValidationException) {
      return await _showErrorDialog(
        title: exception.title,
        message: exception.message,
      );
    }

    return await _showErrorDialog(
      title: t.common.somethingwasWrong,
      message: commonExceptionMessage ?? 'Please contact to us.',
    );
  }

  Future<void> _showErrorDialog({
    String? title,
    String? message,
    Function()? onDismiss,
  }) async {
    await navigator.showDialog(
      AppPopupInfo.errorDialog(
        title: title,
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }
}
