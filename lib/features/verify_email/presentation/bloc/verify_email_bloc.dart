import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../create_account/domain/usecase/send_otp_usecase.dart';
import '../../../create_account/domain/usecase/verify_otp_uescase.dart';

part 'verify_email_bloc.freezed.dart';
part 'verify_email_event.dart';
part 'verify_email_state.dart';

@Injectable()
class VerifyEmailBloc extends BaseBloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc(this._sendOtpUsecase, this._verifyOtpUescase)
      : super(const VerifyEmailState()) {
    on<ClickVerityEvent>(verifyOtp);
    on<InitPageEvent>(_initPage);
  }
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUescase _verifyOtpUescase;
  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<VerifyEmailState> emit) async {
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

  FutureOr<void> verifyOtp(
      ClickVerityEvent event, Emitter<VerifyEmailState> emit) async {
    await runAppCatching(
      () async {
        await _verifyOtpUescase
            .excecute(VerifyOtpInput(email: state.email, otp: event.otp));
        Navigator.pop(event.context, true);
      },
      onError: (error) async {
        debugPrint("your have run on catch ");
      },
    );
  }
}
