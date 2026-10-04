import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/log/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../../domain/usecase/create_account_usecase.dart';

part 'create_user_info_bloc.freezed.dart';
part 'create_user_info_event.dart';
part 'create_user_info_state.dart';

@Injectable()
class CreateUserInfoBloc
    extends BaseBloc<CreateUserInfoEvent, CreateUserInfoState> {
  CreateUserInfoBloc(this._createAccountUsecase)
      : super(const CreateUserInfoState()) {
    on<InitialEvent>(_onInitialEvent);
    on<NameChangedEvent>(_onNameChangedEvent);
    on<PasswordChangedEvent>(_onPasswordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChangedEvent);
    on<TogglePasswordEvent>(_onTogglePasswordEvent);
    on<ToggleConfirmPasswordEvent>(_onToggleConfirmPasswordEvent);
    on<ClickCreateAccountEvent>(_onClickCreateAccountEvent);
    on<ConfirmTnC>(_onConfirmTnCEvent);
    on<ClickTermAndConfition>(_clickTermAndCondition);
  }
  final CreateAccountUsecase _createAccountUsecase;

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(email: event.email, otp: event.otp));
  }

  FutureOr<void> _onTogglePasswordEvent(
      TogglePasswordEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  FutureOr<void> _onToggleConfirmPasswordEvent(
      ToggleConfirmPasswordEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  FutureOr<void> _onClickCreateAccountEvent(
      ClickCreateAccountEvent event, Emitter<CreateUserInfoState> emit) async {
    String? deviceToken;

    /// Catch device token for simulator
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      logE(name: 'Device Token');
    }
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(isLoading: true));
        DeviceInfo deviceInfo = await getDeviceInfo();
        await _createAccountUsecase.excecute(CreateAccountInput(
          email: state.email,
          name: state.name,
          device_token: deviceToken ?? '',
          otp_code: state.otp,
          password: state.password,
          manufacturer: deviceInfo.manufacturer,
          model: deviceInfo.model,
        ));
        emit(state.copyWith(isLoading: false));
        // await LocalStorage.storeData(
        //   key: SharedPreferenceKeys.accessToken,
        //   value: output.access_token,
        // );
        LocalStorage.storeData(
            key: SharedPreferenceKeys.name, value: state.name);
        LocalStorage.storeData(
            key: SharedPreferenceKeys.authType,
            value: SharedPreferenceKeys.password);
        appRoute.replaceAll([const AppRouteInfo.selectSubject()]);
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _onNameChangedEvent(
      NameChangedEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(name: event.value));
  }

  FutureOr<void> _onPasswordChangedEvent(
      PasswordChangedEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(password: event.value));
  }

  FutureOr<void> _clickTermAndCondition(
      ClickTermAndConfition event, Emitter<CreateUserInfoState> emit) async {
    await launchUrl(
      Uri.parse('https://eliezers.com/term-condition'),
    );
  }

  FutureOr<void> _onConfirmPasswordChangedEvent(
      ConfirmPasswordChangedEvent event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(confirmPassword: event.value));
  }

  FutureOr<void> _onConfirmTnCEvent(
      ConfirmTnC event, Emitter<CreateUserInfoState> emit) {
    emit(state.copyWith(confirmTnC: event.valueChanged ?? false));
  }
}
