import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../event/domain/entities/event_entity.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';
part 'event_detail_bloc.freezed.dart';

@Injectable()
class EventDetailBloc extends BaseBloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(const _Initial()) {
    on<InitPage>(_initPage);
    on<ClickJoin>(_clickJoin);
    on<ClickLeave>(_clickLeave);
    on<ClickShare>(_clickShare);
    on<ClickPlaySong>(_clickPlaySond);
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<EventDetailState> emit) async {
    emit(state.copyWith(event: event.event));
  }

  FutureOr<void> _clickShare(
      ClickShare event, Emitter<EventDetailState> emit) async {
    // await shareQuestion();
  }
  FutureOr<void> _clickJoin(ClickJoin event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(event: state.event.copyWith(isJoin: true)));
  }

  FutureOr<void> _clickLeave(ClickLeave event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(event: state.event.copyWith(isJoin: false)));
  }

  FutureOr<void> _clickPlaySond(
      ClickPlaySong event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(playSongIndex: event.index));
  }
}
