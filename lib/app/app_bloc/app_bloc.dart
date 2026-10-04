import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hashids2/hashids2.dart';
import 'package:injectable/injectable.dart';

import '../../config/exceptions/app_exception.dart';
import '../../config/router/page_route/app_route_info.dart';
import '../../config/router/popup_route/app_popup_info.dart';
import '../../core/extension/string_extension.dart';
import '../../core/utils/log/app_logger.dart';
import '../../gen/i18n/translations.g.dart';
import '../base/bloc/base_bloc.dart';
import '../base/bloc/base_event.dart';
import '../base/bloc/base_state.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

@lazySingleton
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppInitstate>(_onAppInitstate);
    on<CacheAppError>(_onCacheAppError);
  }

  final _appLinks = AppLinks();

  FutureOr<void> _onAppInitstate(
      AppInitstate event, Emitter<AppState> emit) async {
    await runAppCatching(
      () async {
        _appLinks.uriLinkStream.listen(_handleDeepLinks);
      },
    );
  }

  void _handleDeepLinks(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return;
    }
    final path = uri.pathSegments.first;

    // final id = uri.pathSegments.lastOrNull;

    // final query = uri.queryParameters;
    try {
      final hashids = HashIds(salt: "eliezersSecret", minHashLength: 20);

      switch (path) {
        case 'notifications':
          appRoute.navigateToBottomTab(3);
          return;
        case 'question':
          final id = uri.pathSegments.lastOrNull;
          // ignore: unused_local_variable
          int? decodeId = hashids.decode("$id").first;
          if (id == null) return;

        // if (appRoute.getCurrentRouteName() == QuestionDetailRoute.name) {
        //   appRoute.popAndPush(AppRouteInfo.questionDetail(id: decodeId));
        //   return;
        // }

        // appRoute.push(AppRouteInfo.questionDetail(id: decodeId));
        // return;

        case 'user':
          final id = uri.pathSegments.lastOrNull;
          int? decodeId = hashids.decode("$id").first;

          if (id.isNotEmptyOrNull) {
            appRoute.push(AppRouteInfo.otherProfile(userId: decodeId));
          }
          return;
        case 'band':
          final id = uri.pathSegments.lastOrNull;
          int? decodeId = hashids.decode("$id").first;
          debugPrint("band id $decodeId");
          // if (id.isNotEmptyOrNull) {
          //   appRoute.push(
          //       AppRouteInfo.bandDetail(BandEntity(), decodeId));
          // }
          return;
      }
    } catch (value) {
      debugPrint("your have on catch $value");
    }
  }

  FutureOr<void> _onCacheAppError(
      CacheAppError onCachedError, Emitter<AppState> emit) async {
    // emit(state.copyWith(error: null));

    final error = onCachedError.error;

    emit(state.copyWith(error: error));

    if (error is DioException) {
      logE(stackTrace: error.stackTrace);
      if (error.response?.data['message'] == 'Unauthenticated.') {
        appRoute.showDialog(
          AppPopupInfo.unAuthenticated(
            message: error.response?.data['message'],
            onPressedButton: () {
              // LocalStorage.remove(SharedPreferenceKeys.accessToken);
              appRoute.replaceAll([const AppRouteInfo.login()]);
            },
          ),
        );
        return;
      }

      final type = error.type;

      switch (type) {
        case DioExceptionType.connectionTimeout:
          appRoute.showDialog(
            const AppPopupInfo.errorDialog(
              title: 'Time Out',
              message: 'Connection Timeout',
            ),
          );
          break;
        case DioExceptionType.sendTimeout:
          appRoute.showDialog(
            const AppPopupInfo.errorDialog(
              title: 'Time Out',
              message: 'Sent Timeout',
            ),
          );
          break;
        case DioExceptionType.receiveTimeout:
          appRoute.showDialog(
            const AppPopupInfo.errorDialog(
              title: 'Time Out',
              message: 'Receive Timeout',
            ),
          );
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          appRoute.showDialog(
            const AppPopupInfo.errorDialog(
              message: 'Connection Error',
            ),
          );
          break;
        case DioExceptionType.unknown:
          appRoute.showDialog(
            AppPopupInfo.errorDialog(
              title: 'Unknown Error',
              message: t.common.somethingwasWrong,
            ),
          );
          break;
      }
    }

    if (error is AppException) {
      final AppExceptionType appExceptionType = error.exceptionType;
      switch (appExceptionType) {
        case AppExceptionType.service:
          appRoute
              .showDialog(AppPopupInfo.errorDialog(message: error.toString()));
          break;
        default:
      }
    }
  }
}
