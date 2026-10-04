import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../create_account/domain/usecase/send_otp_usecase.dart';
import '../../../create_account/domain/usecase/verify_otp_uescase.dart';

part 'verify_email_forgotpassword_bloc.freezed.dart';
part 'verify_email_forgotpassword_event.dart';
part 'verify_email_forgotpassword_state.dart';

@Injectable()
class VerifyEmailForgotpasswordBloc extends BaseBloc<
    VerifyEmailForgotpasswordEvent, VerifyEmailForgotpasswordState> {
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUescase _verifyOtpUescase;
  VerifyEmailForgotpasswordBloc(this._sendOtpUsecase, this._verifyOtpUescase)
      : super(const VerifyEmailForgotpasswordState()) {
    on<ClickVerityEvent>(_verifyOtp);
    on<InitPageEvent>(_initPage);
    on<OtpChangedEvent>(_otpChange);
  }
  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<VerifyEmailForgotpasswordState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(email: event.email));
        await _sendOtpUsecase.excecute(VerifyOtpInput(email: event.email));
      },
      onError: (error) async {
        debugPrint("your have run on catch ");
      },
    );
  }

  FutureOr<void> _otpChange(
      OtpChangedEvent event, Emitter<VerifyEmailForgotpasswordState> emit) {
    emit(state.copyWith(errorState: false));
  }

  FutureOr<void> _verifyOtp(ClickVerityEvent event,
      Emitter<VerifyEmailForgotpasswordState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(isloading: true));
        final verify = await _verifyOtpUescase
            .excecute(VerifyOtpInput(email: state.email, otp: event.otp));
        emit(state.copyWith(isloading: false));

        if (verify.is_scussess) {
          appRoute
              .popAndPush(AppRouteInfo.resetPassword(state.email, event.otp));
        } else {
          emit(state.copyWith(errorState: true));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false, errorState: false));
        debugPrint("your have run on catch ");
      },
    );
  }
}
