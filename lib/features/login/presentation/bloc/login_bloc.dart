import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';

import '../../../walk_though/singin/controller/auth_gmail_service.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';

part 'login_event.dart';
part 'login_state.dart';

part 'login_bloc.freezed.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<LoginEvent>((event, emit) async {
      await event.map(
        EmailChangedEvent: (EmailChangedEvent) async {
          await _onEmailChangedEvent(emit, EmailChangedEvent);
        },
        passwordChanged: (passwordChanged) async {
          await _onPasswordChanged(emit, passwordChanged);
        },
        clickedButtonLogin: (_) async {
          await _onClickedButtonLogin(emit);
        },
        clickForgotPassword: (value) async {
          await _onClickedForgetPassword();
        },
        clickLoginWithGmail: (value) async {
          await _onClickedLoginWithGmail();
        },
      );
    });
  }

  FutureOr<void> _onEmailChangedEvent(
      Emitter<LoginState> emit, _EmailChangedEvent EmailChangedEvent) async {
    final newState = state.copyWith(
      email: EmailChangedEvent.email,
      emailError: null,
      passwordError: null,
    );

    emit(newState.copyWith(enableLogin: enableLogin(newState)));

    return;
  }

  FutureOr<void> _onPasswordChanged(
      Emitter<LoginState> emit, _PasswordChanged passwordChanged) async {
    final newState = state.copyWith(
      password: passwordChanged.password,
      emailError: null,
      passwordError: null,
    );

    emit(newState.copyWith(enableLogin: enableLogin(newState)));
  }

  FutureOr<void> _onClickedButtonLogin(Emitter<LoginState> emit) async {
    await runAppCatching(
      () async {
        unFocus();
        emit(state.copyWith(loading: true));
        await LocalStorage.storeData(
            key: 'access_token', value: 'sample_token');
        await Future.delayed(const Duration(seconds: 2));
        // emit(state.copyWith(loading: false));

        if (corretEmail && corretPassword) {
          appRoute.replace(const AppRouteInfo.home());
        } else {
          final newState = state.copyWith(
            loading: false,
            emailError: corretEmail ? null : 'Email Not Found',
            passwordError: corretPassword ? null : 'Wrong Password',
          );

          emit(newState);
        }
      },
      onError: (e) async {
        emit(state.copyWith(loading: false));
      },
    );
  }

  bool enableLogin(LoginState newState) =>
      newState.email.length >= 8 && newState.password.length >= 8;

  bool get corretEmail => state.email == 'virak@gmail.com';
  bool get corretPassword => state.password == '12345678';

  FutureOr<void> _onClickedLoginWithGmail() {
    AuthGmailService.obj.signInWithGoogle();
  }

  FutureOr<void> _onClickedForgetPassword() {
    appRoute.push(const AppRouteInfo.forgotPassword());
  }
}
