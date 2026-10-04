import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/forgot_password_api_service.dart';
import '../../domain/usecase/create_new_password_usercase.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';

part 'create_new_password_bloc_event.dart';
part 'create_new_password_bloc_state.dart';
part 'create_new_password_bloc_bloc.freezed.dart';

@Injectable()
class CreateNewPasswordBlocBloc
    extends BaseBloc<CreateNewPasswordBlocEvent, CreateNewPasswordBlocState> {
  CreateNewPasswordBlocBloc(this._createNewPasswordUsercase)
      : super(const _Initial()) {
    on<ClickCreateNewPassword>(_createNewpassword);
    on<PasswordChangedEvent>(_passwordChanged);
  }
  final CreateNewPasswordUsercase _createNewPasswordUsercase;

  FutureOr _passwordChanged(
      PasswordChangedEvent event, Emitter<CreateNewPasswordBlocState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr _createNewpassword(ClickCreateNewPassword event,
      Emitter<CreateNewPasswordBlocState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final deviceInfo = await getDeviceInfo();
        final loginEnity = await _createNewPasswordUsercase.excecute(
            CreateNewPassWordInput(
                email: event.email,
                otp: "",
                new_password: state.password,
                model: deviceInfo.model));
        await LocalStorage.storeData(
          key: SharedPreferenceKeys.accessToken,
          value: loginEnity.token,
        );
        emit(state.copyWith(isloading: false));
        appRoute.replaceAll([const AppRouteInfo.home()]);
      },
    );
  }
}
