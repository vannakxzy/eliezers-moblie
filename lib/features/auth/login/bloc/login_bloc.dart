// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../app/exception_handler/app_exception.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../../../create_account/domain/usecase/create_account_usecase.dart';
import '../../../login/data/data_sources/remote/login_api_service.dart';
import '../../../login/domain/usecase/auth_with_google_usecase.dart';
import '../../../login/domain/usecase/check_user_usecase.dart';
import '../../../login/domain/usecase/login_usecase.dart';
import '../../../walk_though/singin/controller/auth_gmail_service.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final CreateAccountUsecase _createAccountUsecase;
  final AuthWithGoogleUsecase _authWithGoogleUsecase;
  final CheckUserUsecase _checkUserUsecase;
  LoginBloc(this._loginUseCase, this._createAccountUsecase,
      this._authWithGoogleUsecase, this._checkUserUsecase)
      : super(const LoginState()) {
    on<EmailChangedEvent>(_onEmailChangedEvent);
    on<PasswordChange>(_onPasswordChanged);
    on<ClickButtonLogin>(_onClickedButtonLogin);
    on<ClickLoginWithEmail>(_onClickedLoginWithGmail);
    on<ClickForgotPassword>(_onClickedForgetPassword);
    on<ClickCreateEventAccountEvent>(_onClickedCreateAccount);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }

  FutureOr<void> _togglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  FutureOr<void> _onEmailChangedEvent(
      EmailChangedEvent EmailChangedEvent, Emitter<LoginState> emit) async {
    final newState = state.copyWith(
      email: EmailChangedEvent.value,
      emailError: null,
      passwordError: null,
    );
    emit(newState.copyWith(enableLogin: _enableLogin(newState)));
    return;
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChange passwordChanged, Emitter<LoginState> emit) async {
    final newState = state.copyWith(
      password: passwordChanged.value,
      emailError: null,
      passwordError: null,
    );

    emit(newState.copyWith(enableLogin: _enableLogin(newState)));
  }

  FutureOr<void> _onClickedButtonLogin(
      ClickButtonLogin event, Emitter<LoginState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loading: true));

        if (!state.validLogin) {
          throw ValidationException(
            title: 'Invalid',
            message: 'Invalid Email or Password!',
          );
        }

        await _checkUserUsecase.excecute(CheckUserInput(
            email: state.email, password: state.password, name: ""));

        emit(state.copyWith(
          loading: false,
          emailError: null,
          passwordError: null,
        ));
        appRoute.push(AppRouteInfo.verifyLogin(state.email, state.password));
      },
      onError: (e) async {
        emit(state.copyWith(loading: false));
      },
      handleError: true,
    );
  }

  // this for check condition to enable button login base on lartest state value
  bool _enableLogin(LoginState newState) =>
      newState.email.isEmail && newState.password.length >= 8;

  FutureOr<void> _onClickedLoginWithGmail(
      ClickLoginWithEmail event, Emitter<LoginState> emit) async {
    await runAppCatching(
      () async {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? deviceToken = await messaging.getToken();
        debugPrint("deviceToken : $deviceToken");
        GoogleSignInAccount? user =
            await AuthGmailService.obj.signInWithGoogle();
        DeviceInfo deviceInfo = await getDeviceInfo();
        if (user != null) {
          final input = CreateAccountInput(
              otp_code: "",
              manufacturer: deviceInfo.manufacturer,
              model: deviceInfo.model,
              email: user.email,
              password: "",
              device_token: deviceToken ?? "",
              name: user.displayName ?? "");
          emit(state.copyWith(loadingGmail: true));
          final loginEnity = await _authWithGoogleUsecase.excecute(input);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.accessToken, value: loginEnity.token);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.name, value: user.displayName);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.authType,
              value: SharedPreferenceKeys.email);
          if (loginEnity.isLogin) {
            appRoute.push(const AppRouteInfo.home());
          } else {
            appRoute.push(const AppRouteInfo.selectSubject());
          }
          emit(state.copyWith(loadingGmail: false));
          emit(state.copyWith(
            loading: false,
            emailError: null,
            passwordError: null,
          ));
        }
      },
      onError: (error) async {
        emit(state.copyWith(
          loading: false,
          loadingGmail: false,
          emailError: null,
          passwordError: null,
        ));
        debugPrint("you have error  $error");
      },
    );
  }

  FutureOr<void> _onClickedForgetPassword(
      ClickForgotPassword event, Emitter<LoginState> emit) {
    appRoute.push(const AppRouteInfo.forgotPassword());
  }

  FutureOr<void> _onClickedCreateAccount(
      ClickCreateEventAccountEvent event, Emitter<LoginState> emit) {
    appRoute.push(const AppRouteInfo.createAccount());
  }
}
