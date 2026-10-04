import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../data/data_sources/remotes/forgot_password_api_service.dart';
import '../../../domain/usecase/create_new_password_usercase.dart';

import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

@Injectable()
class ResetPasswordBloc
    extends BaseBloc<ResetPasswordEvent, ResetPasswordState> {
  final CreateNewPasswordUsercase _createNewPasswordUsercase;
  ResetPasswordBloc(this._createNewPasswordUsercase) : super(const _Initial()) {
    on<ClickConfirmEvent>(_clickConfirm);
    on<PasswordChanged>(_passwordChange);
  }
  FutureOr<void> _clickConfirm(
      ClickConfirmEvent event, Emitter<ResetPasswordState> emit) async {
    await runAppCatching(handleError: true, () async {
      emit(state.copyWith(isloading: true));
      final deviceInfo = await getDeviceInfo();
      final respose = await _createNewPasswordUsercase.excecute(
          CreateNewPassWordInput(
              email: event.email,
              new_password: state.password,
              model: deviceInfo.model,
              otp: event.otp));
      LocalStorage.storeData(
          key: SharedPreferenceKeys.accessToken, value: respose.token);
      LocalStorage.storeData(
          key: SharedPreferenceKeys.email, value: event.email);
      LocalStorage.storeData(
          key: SharedPreferenceKeys.authType,
          value: SharedPreferenceKeys.password);
      appRoute.pushAll([const AppRouteInfo.home()]);
      emit(state.copyWith(isloading: false));
    }, onError: (value) async {
      emit(state.copyWith(isloading: false));
    });
  }

  FutureOr<void> _passwordChange(
      PasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(password: event.value));
  }
}
