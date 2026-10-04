import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/base/bloc/bloc.dart';
import '../../../config/router/page_route/app_route_info.dart';

part 'scaffold_with_navbar_bloc.freezed.dart';
part 'scaffold_with_navbar_event.dart';
part 'scaffold_with_navbar_state.dart';

@Injectable()
class ScaffoldWithNavbarBloc
    extends BaseBloc<ScaffoldWithNavbarEvent, ScaffoldWithNavbarState> {
  ScaffoldWithNavbarBloc() : super(ScaffoldWithNavbarState()) {
    on<PressedHomeButtonEvent>(_onPressedHomeButtonEvent);
    on<ScrollDirectionUpdateEvent>(_onScrollDirectionUpdateEvent);
    on<ClickClearAnonymous>(_clearAnonymous);
    on<ClickLeaveAnonymousEvent>(_leaveAnonymous);
    on<MakeToAnonymousEvent>(_makeToAnonymousEvent);
  }
  FutureOr<void> _clearAnonymous(
      ClickClearAnonymous event, Emitter<ScaffoldWithNavbarState> emit) {
    emit(state.copyWith(isAnonymous: false));
  }

  FutureOr<void> _makeToAnonymousEvent(
      MakeToAnonymousEvent event, Emitter<ScaffoldWithNavbarState> emit) {
    emit(state.copyWith(isAnonymous: true));
  }

  FutureOr<void> _leaveAnonymous(
      ClickLeaveAnonymousEvent event, Emitter<ScaffoldWithNavbarState> emit) {
    emit(state.copyWith(isAnonymous: false));
    Future.delayed(const Duration(milliseconds: 200), () {
      appRoute.replaceAll([
        const AppRouteInfo.login(),
      ]);
    });
  }

  final scrollController = ScrollController();

  bool get isScrolled =>
      scrollController.hasClients && scrollController.offset > 0;

  FutureOr<void> _onScrollDirectionUpdateEvent(
      ScrollDirectionUpdateEvent event, Emitter<ScaffoldWithNavbarState> emit) {
    emit(
      state.copyWith(isShowButton: event.isScrollingDown),
    );
  }

  FutureOr<void> _onPressedHomeButtonEvent(
      PressedHomeButtonEvent event, Emitter<ScaffoldWithNavbarState> emit) {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
