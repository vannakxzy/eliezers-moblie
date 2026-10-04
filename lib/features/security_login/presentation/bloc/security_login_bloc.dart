// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../domain/usecase/delete_acccount_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../domain/usecase/logout_usecase.dart';

part 'security_login_event.dart';
part 'security_login_state.dart';
part 'security_login_bloc.freezed.dart';

@Injectable()
class SecurityLoginBloc
    extends BaseBloc<SecurityLoginEvent, SecurityLoginState> {
  final DeleteUserUsecase _deleteUserUsecase;
  final LogoutUsecase _logoutUsecase;
  SecurityLoginBloc(this._deleteUserUsecase, this._logoutUsecase)
      : super(const _Initial()) {
    on<ClickBlockEvent>(_clickBlock);
    on<ClickHideEvent>(_clickHide);
    on<ClickChangePasswordEvent>(_clickChangePassword);
    on<ClickLogoutEvent>(_clickLogout);
    on<ClickActiveSession>(_clickActiveSession);
    on<DeleteAccount>(_deleteAccount);
  }
  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<SecurityLoginState> emit) {
    appRoute.push(const AppRouteInfo.hide());
  }

  FutureOr<void> _clickActiveSession(
      ClickActiveSession event, Emitter<SecurityLoginState> emit) {
    appRoute.push(const AppRouteInfo.activeSession());
  }

  FutureOr<void> _clickBlock(
      ClickBlockEvent event, Emitter<SecurityLoginState> emit) {
    appRoute.push(const AppRouteInfo.block());
  }

  FutureOr<void> _clickChangePassword(
      ClickChangePasswordEvent event, Emitter<SecurityLoginState> emit) {
    appRoute.push(const AppRouteInfo.changePassword());
  }

  FutureOr<void> _clickLogout(
      ClickLogoutEvent event, Emitter<SecurityLoginState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(logoutLoading: true));
        // appRoute.popAndPushAll([const AppRouteInfo.login()]);
        appRoute.replaceAll([const AppRouteInfo.home()]);
        appRoute.push(AppRouteInfo.login());
        await _logoutUsecase.excecute('');
        await LocalStorage.storeData(
            key: SharedPreferenceKeys.accessToken, value: '');
        emit(state.copyWith(logoutLoading: false));
      },
      onError: (error) async {
        emit(state.copyWith(logoutLoading: false));
      },
    );
  }

  FutureOr<void> _deleteAccount(
      DeleteAccount event, Emitter<SecurityLoginState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(deleteLoaing: true));
        await _deleteUserUsecase.excecute('');
        emit(state.copyWith(deleteLoaing: false));
        add(ClickLogoutEvent());
      },
      onError: (error) async {
        emit(state.copyWith(deleteLoaing: false));
      },
    );
  }
}
