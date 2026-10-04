import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../personal_info/domain/usecase/check_email_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

@Injectable()
class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._checkEmailUseCase) : super(const _Initial()) {
    on<EmailChangedEventEvent>(_EmailChangedEvent);
    on<ClickConfirmEventEvent>(_onClickComfirm);
  }
  final CheckEmailUseCase _checkEmailUseCase;

  FutureOr<void> _EmailChangedEvent(
      EmailChangedEventEvent event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(email: event.value, isToken: false));
  }

  FutureOr<void> _onClickComfirm(
      ClickConfirmEventEvent event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isToken: false));
      final isHave = await _checkEmailUseCase.excecute(state.email);
      emit(state.copyWith(isLoading: false));
      if (isHave == 0) {
        emit(state.copyWith(isToken: true));
      } else {
        appRoute.push(AppRouteInfo.verifyOtpForgotpassword(email: state.email));
      }
    } catch (e) {
      debugPrint("ddddddddd$e");
    }
  }
}
