import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';
part 'change_password_bloc.freezed.dart';

@Injectable()
class ChangePasswordBloc
    extends BaseBloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordState()) {
    on<ClickConfirmEvent>(_clickComfrim);
    on<CurrentPasswordChangeEvent>(_currentPasswordChange);
    on<NewPasswordChangedEvent>(_newPasswordChange);
    on<ReTypeNewPasswordEvent>(_reTypeNewPasswordChange);
  }

  FutureOr<void> _currentPasswordChange(
      CurrentPasswordChangeEvent event, Emitter<ChangePasswordState> emit) {
    // emit(state.copyWith(currentPassword: event.value));
    enableButton(emit);
  }

  FutureOr<void> _newPasswordChange(
      NewPasswordChangedEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(newPassword: event.value));
    enableButton(emit);
  }

  FutureOr<void> _reTypeNewPasswordChange(
      ReTypeNewPasswordEvent event, Emitter<ChangePasswordState> emit) {
    // emit(state.copyWith(reTypeNewpassword: event.value));
    enableButton(emit);
  }

  FutureOr<void> _clickComfrim(
      ClickConfirmEvent event, Emitter<ChangePasswordState> emit) async {
    appRoute
        .popAndPush(AppRouteInfo.verifyOtpChangePassword(state.newPassword));
  }

  enableButton(Emitter<ChangePasswordState> emit) {
    if (state.newPassword.length >= 8) {
      emit(state.copyWith(enableButton: true));
    } else {
      emit(state.copyWith(enableButton: false));
    }
  }
}
