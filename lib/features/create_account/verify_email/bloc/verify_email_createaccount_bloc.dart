import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../domain/usecase/send_otp_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../domain/usecase/verify_otp_uescase.dart';

part 'verify_email_createaccount_bloc.freezed.dart';
part 'verify_email_createaccount_event.dart';
part 'verify_email_createaccount_state.dart';

@Injectable()
class VerifyEmailCreateaccountBloc extends BaseBloc<
    VerifyEmailCreateaccountEvent, VerifyEmailCreateaccountState> {
  VerifyEmailCreateaccountBloc(
    this._sendOtpUsecase,
    this._verifyOtpUescase,
  ) : super(const VerifyEmailCreateaccountState()) {
    on<InitPageEvent>(_initPage);
    on<ClickVerityEvent>(_verifyOtp);
    on<OtpChangedEvent>(_otpChanged);
  }
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUescase _verifyOtpUescase;
  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<VerifyEmailCreateaccountState> emit) async {
    emit(state.copyWith(email: event.email));
    await runAppCatching(
      () async {
        await _sendOtpUsecase.excecute(VerifyOtpInput(email: event.email));
      },
      onError: (error) async {
        debugPrint("your have run on catch ");
      },
    );
  }

  FutureOr<void> _verifyOtp(ClickVerityEvent event,
      Emitter<VerifyEmailCreateaccountState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(isloading: true));
        final response = await _verifyOtpUescase
            .excecute(VerifyOtpInput(email: state.email, otp: event.otp));
        emit(state.copyWith(isloading: false));
        if (response.is_scussess) {
          appRoute.push(AppRouteInfo.createUserInfo(state.email, event.otp));
        } else {
          emit(state.copyWith(errorState: true));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
        debugPrint("you have been catch $error");
      },
    );
  }

  FutureOr<void> _otpChanged(
      OtpChangedEvent event, Emitter<VerifyEmailCreateaccountState> emit) {
    emit(state.copyWith(errorState: false));
  }
}
