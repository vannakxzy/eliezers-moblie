import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/security_login/hide_model.dart';
import '../../domain/usecase/get_hide_usecase.dart';
import '../../domain/usecase/un_hide_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../domain/entities/hide_entity.dart';

part 'hide_event.dart';
part 'hide_state.dart';
part 'hide_bloc.freezed.dart';

@Injectable()
class HideBloc extends BaseBloc<HideEvent, HideState> {
  HideBloc(this._getHideUseCase, this._unHideUsecase)
      : super(const HideState()) {
    on<GetHideEvent>(_getHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<RefreshPage>(_refreshPage);
  }
  final GetHideUseCase _getHideUseCase;
  final UnHideUsecase _unHideUsecase;

  FutureOr<void> _getHide(GetHideEvent event, Emitter<HideState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final hideRespose = await _getHideUseCase.excecute(state.page);
        final all = [...state.hides];
        all.addAll(hideRespose.data!.toListEntity());
        emit(
            state.copyWith(hides: all, isLoading: false, page: state.page + 1));
        if (state.page > hideRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<HideState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(page: 1));
        emit(state.copyWith(isLoading: true, isMorePage: true));
        final hideRespose = await _getHideUseCase.excecute(state.page);
        emit(state.copyWith(
            hides: hideRespose.data!.toListEntity(),
            isLoading: false,
            page: state.page + 1));
        if (state.page > hideRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _clickUnHide(
      ClickUnHideEvent event, Emitter<HideState> emit) async {
    await runAppCatching(
      () async {
        // emit(state.copyWith(isLoading: true));
        final hide = [...state.hides];
        hide.removeAt(event.index);
        await _unHideUsecase.excecute(state.hides[event.index].id ?? 0);
        emit(state.copyWith(hides: hide));
      },
      onError: (error) async {
        debugPrint("unhide error $error");
      },
    );
  }
}
