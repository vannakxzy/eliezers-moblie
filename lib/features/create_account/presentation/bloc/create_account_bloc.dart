import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../domain/entities/create_account_entity.dart';
import '../../domain/usecase/create_account_usecase.dart';

part 'create_account_bloc.freezed.dart';
part 'create_account_event.dart';
part 'create_account_state.dart';

@Injectable()
class CreateAccountBloc
    extends BaseBloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc(this._createAccountUsecase) : super(const _Initial()) {
    on<NameChangedEvent>(_onChnageName);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<ClickCreateEventAccountEvent>(_onClickCreateEventAccountEvent);
    on<EmailChangedEvent>(_onEmailChangedEvent);
  }
  final CreateAccountUsecase _createAccountUsecase;

  void validateButton(
    Emitter<CreateAccountState> emit,
  ) {
    if (state.email.isEmptyOrNull ||
        state.password.isEmptyOrNull ||
        state.name.isEmptyOrNull) {
      emit(state.copyWith(validateButton: true));
      return;
    }
    emit(state.copyWith(validateButton: false));
  }

  FutureOr<void> _onClickCreateEventAccountEvent(
    ClickCreateEventAccountEvent event,
    Emitter<CreateAccountState> emit,
  ) async {
    await runAppCatching(
      () async {
        try {
          if (state.email.isEmpty) return;
          emit(state.copyWith(isLoading: true));
          DeviceInfo deviceInfo = await getDeviceInfo();
          CreateAccountEntity output =
              await _createAccountUsecase.excecute(CreateAccountInput(
            email: state.email,
            name: state.name,
            device_token: '',
            otp_code: "",
            password: state.password,
            manufacturer: deviceInfo.manufacturer,
            model: deviceInfo.model,
          ));
          emit(state.copyWith(isLoading: false));
          await LocalStorage.storeData(
            key: SharedPreferenceKeys.accessToken,
            value: output.token,
          );
          LocalStorage.storeData(
              key: SharedPreferenceKeys.name, value: state.name);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.authType,
              value: SharedPreferenceKeys.password);
          appRoute.replaceAll([const AppRouteInfo.home()]);
          debugPrint("loggggggggg  ");
        } catch (e) {
          debugPrint("errriir  $e");
        }
      },
      onError: (v) async {
        debugPrint("Error $v");
        emit(state.copyWith(isLoading: false));
      },
      handleError: true,
    );
  }

  FutureOr<void> _onEmailChangedEvent(
      EmailChangedEvent event, Emitter<CreateAccountState> emit) async {
    emit(state.copyWith(email: event.value, emailTaken: false));
    validateButton(emit);
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChangedEvent event, Emitter<CreateAccountState> emit) async {
    emit(state.copyWith(password: event.value));
    validateButton(emit);
  }

  FutureOr<void> _onChnageName(
      NameChangedEvent event, Emitter<CreateAccountState> emit) async {
    emit(state.copyWith(name: event.value));
    validateButton(emit);
  }
}
