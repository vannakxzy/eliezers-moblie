import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../base/bloc/bloc.dart';

part 'global_notify_bloc.freezed.dart';
part 'global_notify_event.dart';
part 'global_notify_state.dart';

@lazySingleton
class GlobalNotifyBloc extends BaseBloc<GlobalNotifyEvent, GlobalNotifyState> {
  GlobalNotifyBloc() : super(const GlobalNotifyState()) {
    on<GlobalNotifyPageInitiated>(_onGlobalNotifyPageInitiated);
    on<NotifyState>(_onNotifyState);
  }

  FutureOr<void> _onGlobalNotifyPageInitiated(
    GlobalNotifyPageInitiated event,
    Emitter<GlobalNotifyState> emit,
  ) async {}

  FutureOr<void> _onNotifyState(NotifyState<BaseState> event,
      Emitter<GlobalNotifyState<BaseState>> emit) async {
    await runAppCatching(
      () async {
        final newStates = {...state.states};
        newStates[event.type] = event.newState;
        emit(state.copyWith(states: newStates));
      },
    );
  }
}

extension GlobalStateX on BuildContext {
  T? pick<T extends BaseState>() =>
      BlocProvider.of<GlobalNotifyBloc>(this).state.pick<T>();
}
