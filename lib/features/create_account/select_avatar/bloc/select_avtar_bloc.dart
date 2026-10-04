// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../domain/usecase/update_avtar_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../domain/entities/avatar_entity.dart';
import '../../domain/usecase/get_avtar_usecase.dart';

part 'select_avtar_event.dart';
part 'select_avtar_state.dart';
part 'select_avtar_bloc.freezed.dart';

@Injectable()
class SelectAvatarBloc extends BaseBloc<SelectAvatarEvent, SelectAvatarState> {
  SelectAvatarBloc(this._getAvatarUsecase, this._updateAvtarUsecase)
      : super(const _Initial()) {
    on<GetAvatar>(_getAvata);
    on<ClickAvatar>(_clickAvatar);
    on<ClickConfirmEvent>(_clickConfirmEvent);
    on<ClickSkipEvent>(_clickSkip);
  }
  final GetAvatarUsecase _getAvatarUsecase;
  final UpdateAvtarUsecase _updateAvtarUsecase;

  FutureOr<void> _getAvata(
      GetAvatar event, Emitter<SelectAvatarState> emit) async {
    await runAppCatching(
      handleError: true,
      () async {
        emit(state.copyWith(isLoadin: true));
        final avatar = await _getAvatarUsecase.excecute('');
        emit(state.copyWith(avatar: avatar));
        emit(state.copyWith(isLoadin: false));
      },
      onError: (error) async {
        emit(state.copyWith(isLoadin: false));
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickAvatar(
      ClickAvatar event, Emitter<SelectAvatarState> emit) async {
    emit(state.copyWith(selectedIndex: event.index));
  }

  FutureOr<void> _clickSkip(
      ClickSkipEvent event, Emitter<SelectAvatarState> emit) {
    appRoute.replaceAll([const AppRouteInfo.home()]);
  }

  FutureOr<void> _clickConfirmEvent(
      ClickConfirmEvent event, Emitter<SelectAvatarState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(submitLoading: true));
        await _updateAvtarUsecase
            .excecute(state.avatar[state.selectedIndex].name);
        emit(state.copyWith(submitLoading: false));
        appRoute.replaceAll([const AppRouteInfo.home()]);
      },
      onError: (error) async {
        emit(state.copyWith(submitLoading: false));
        appRoute.replaceAll([const AppRouteInfo.home()]);
      },
    );
  }
}
