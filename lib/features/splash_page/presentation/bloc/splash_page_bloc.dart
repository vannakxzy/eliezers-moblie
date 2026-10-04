// ignore_for_file: void_checks

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/app_router.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../di/di.dart';
import '../../domain/usecase/get_slogan_usecase.dart';

part 'splash_page_bloc.freezed.dart';
part 'splash_page_event.dart';
part 'splash_page_state.dart';

@Injectable()
class SplashPageBloc extends BaseBloc<SplashPageEvent, SplashPageState> {
  SplashPageBloc() : super(const _Initial()) {
    on<InitSplashPageEvent>(_initSplash);
  }

  FutureOr<void> _initSplash(
    InitSplashPageEvent event,
    Emitter<SplashPageState> emit,
  ) async {
    String token =
        LocalStorage.getStringValue(SharedPreferenceKeys.accessToken);
    if (token.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      appRoute.replaceAll([const AppRouteInfo.home()]);
    } else {
      await Future.delayed(const Duration(seconds: 2));
      appRoute.replaceAll([const AppRouteInfo.login()]);
    }
  }
}
