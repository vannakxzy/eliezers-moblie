import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../login/domain/usecase/login_usecase.dart';

import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../../create_account/domain/usecase/send_otp_usecase.dart';
import '../../../../login/data/data_sources/remote/login_api_service.dart';

part 'verify_otp_login_event.dart';
part 'verify_otp_login_state.dart';
part 'verify_otp_login_bloc.freezed.dart';

@Injectable()
class VerifyOtpLoginBloc
    extends BaseBloc<VerifyOtpLoginEvent, VerifyOtpLoginState> {
  VerifyOtpLoginBloc(this._loginUseCase, this._sendOtpUsecase)
      : super(_Initial()) {
    on<InitPageEvent>(_initPage);
    on<OtpChangedEvent>(_otpChanged);
    on<ClickVerityEvent>(_clickVerify);
  }
  final LoginUseCase _loginUseCase;
  final SendOtpUsecase _sendOtpUsecase;
  FutureOr<void> _clickVerify(
      ClickVerityEvent event, Emitter<VerifyOtpLoginState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(isloading: true));
        DeviceInfo deviceInfo = await getDeviceInfo();
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? deviceToken = await messaging.getToken();
        final input = LoginInput(
            manufacturer: deviceInfo.manufacturer,
            email: state.email,
            model: deviceInfo.model,
            device_token: deviceToken ?? "",
            otp: event.otp,
            password: event.password,
            name: "");
        final loginEnity = await _loginUseCase.excecute(input);
        emit(state.copyWith(isloading: false));
        if (loginEnity.is_scussess) {
          LocalStorage.storeData(
              key: SharedPreferenceKeys.accessToken, value: loginEnity.token);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.name, value: loginEnity.name);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.email, value: state.email);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.authType,
              value: SharedPreferenceKeys.password);

          appRoute.pushAll([const AppRouteInfo.home()]);
        } else {
          debugPrint("dfdsfsdfsdf");
          emit(state.copyWith(isloading: false));
          emit(state.copyWith(errorState: true));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<VerifyOtpLoginState> emit) async {
    emit(state.copyWith(email: event.email));
    await runAppCatching(
      () async {
        await _sendOtpUsecase.excecute(VerifyOtpInput(email: event.email));
      },
      onError: (error) async {
        debugPrint("your have run on catch ");
      },
    );
    return null;
  }

  FutureOr<void> _otpChanged(
      OtpChangedEvent event, Emitter<VerifyOtpLoginState> emit) {
    emit(state.copyWith(errorState: false));
  }
}
