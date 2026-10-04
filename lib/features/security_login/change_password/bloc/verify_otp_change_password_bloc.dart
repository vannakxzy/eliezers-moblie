import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/verify_email_api_service.dart';
import '../../../create_account/domain/usecase/send_otp_usecase.dart';
import '../../../create_account/domain/usecase/verify_otp_uescase.dart';
import '../../domain/usecase/change_password_usecase.dart';

part 'verify_otp_change_password_event.dart';
part 'verify_otp_change_password_state.dart';
part 'verify_otp_change_password_bloc.freezed.dart';

@Injectable()
class VerifyOtpChangePasswordBloc extends BaseBloc<VerifyOtpChangePasswordEvent,
    VerifyOtpChangePasswordState> {
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUescase _verifyOtpUescase;
  final ChangePasswordUsecase _changePasswordUsecase;

  VerifyOtpChangePasswordBloc(
      this._sendOtpUsecase, this._verifyOtpUescase, this._changePasswordUsecase)
      : super(const _Initial()) {
    on<InitPageEventP>(_initPage);
    on<ClickVerityEvent>(_verifyOtp);
    on<OtpChangedEvent>(_otpChange);
  }
  FutureOr<void> _initPage(
      InitPageEventP event, Emitter<VerifyOtpChangePasswordState> emit) async {
    await runAppCatching(
      () async {
        String email = LocalStorage.getStringValue(SharedPreferenceKeys.email);
        debugPrint("email $email");
        await _sendOtpUsecase.excecute(VerifyOtpInput(email: email));
      },
      onError: (error) async {
        debugPrint("your have run on catch $error ");
      },
    );
    return null;
  }

  FutureOr<void> _verifyOtp(ClickVerityEvent event,
      Emitter<VerifyOtpChangePasswordState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        String email = LocalStorage.getStringValue(SharedPreferenceKeys.email);
        emit(state.copyWith(isloading: true));
        final response = await _verifyOtpUescase
            .excecute(VerifyOtpInput(email: email, otp: event.otp));
        if (response.is_scussess) {
          final loginEnity =
              await _changePasswordUsecase.excecute(event.password);
          LocalStorage.storeData(
              key: SharedPreferenceKeys.accessToken, value: loginEnity.token);
          emit(state.copyWith(isloading: false));
          appRoute.pop();
          appRoute.showInfoSnackBar(t.securtyLogin.changePasswordSeccuss);
        } else {
          emit(state.copyWith(errorState: true, isloading: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false, errorState: false));
        debugPrint("your have run on catch ");
      },
    );
  }

  FutureOr<void> _otpChange(
      OtpChangedEvent event, Emitter<VerifyOtpChangePasswordState> emit) {
    emit(state.copyWith(errorState: false));
  }
}
