// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../domain/usecase/delete_active_session_usecase.dart';
import '../../domain/usecase/delete_other_sesstion_usecase.dart';
import '../../domain/usecase/get_active_session_usecase.dart';

import '../../../../app/base/bloc/base_bloc.dart';
import '../../domain/entities/active_session_entity.dart';

part 'active_session_event.dart';
part 'active_session_state.dart';
part 'active_session_bloc.freezed.dart';

@Injectable()
class ActiveSessionBloc
    extends BaseBloc<ActiveSessionEvent, ActiveSessionState> {
  final GetActiveSessionUsecase _getActiveSessionUsecase;
  final DeleteActiveSessionUsecase _deleteActiveSessionUsecase;
  final DeleteOtherSesstionUsecase _deleteOtherSesstionUsecase;
  ActiveSessionBloc(this._getActiveSessionUsecase,
      this._deleteActiveSessionUsecase, this._deleteOtherSesstionUsecase)
      : super(const _Initial()) {
    on<GetActiveSession>(_getActiveSession);
    on<DeleteOneActiveSession>(_deleteOneSession);
    on<DeleteOtherActiveSession>(_deleteOtherSession);
  }
  Future<void> _getActiveSession(
      GetActiveSession event, Emitter<ActiveSessionState> emit) async {
    await runAppCatching(
      () async {
        List<ActiveSessionEntity> active =
            await _getActiveSessionUsecase.excecute('');
        emit(state.copyWith(yourDevice: active[0]));
        active.removeAt(0);
        emit(state.copyWith(activeSession: active));
        emit(state.copyWith(activeSession: active, isLoading: false));
      },
      onError: (error) async {
        debugPrint("you have on error $error");
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _deleteOneSession(
      DeleteOneActiveSession event, Emitter<ActiveSessionState> emit) async {
    await runAppCatching(() async {
      debugPrint("sdfdsfsdfsdfsdfds");
      final session = [...state.activeSession];
      final id = session[event.index].id;
      session.removeAt(event.index);
      emit(state.copyWith(activeSession: session));
      await _deleteActiveSessionUsecase.excecute(id ?? 0);
    }, onError: (value) async {
      debugPrint("you have been on catch $value");
    });
  }

  FutureOr<void> _deleteOtherSession(
      DeleteOtherActiveSession event, Emitter<ActiveSessionState> emit) async {
    await runAppCatching(
      () async {
        final session = [...state.activeSession];
        session.clear();
        emit(state.copyWith(activeSession: session));
        await _deleteOtherSesstionUsecase.excecute('');
      },
      onError: (error) async {
        debugPrint("you have been on catch ");
      },
    );
  }
}
