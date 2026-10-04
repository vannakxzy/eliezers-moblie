import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/models/event/event_model.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/usecase/get_events_usecase.dart';
part 'event_event.dart';
part 'event_state.dart';
part 'event_bloc.freezed.dart';

@Injectable()
class EventBloc extends BaseBloc<EventEvent, EventState> {
  EventBloc(this._getEventsUsecase) : super(const EventState()) {
    on<InitPage>(_initPage);
    on<ClickEvent>(_clickEvents);
    on<Refreshpage>(_refreshPage);
    on<ClickJoin>(_clickJoin);
  }
  final GetEventsUsecase _getEventsUsecase;

  FutureOr<void> _initPage(InitPage event, Emitter<EventState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final eventRespose = await _getEventsUsecase.excecute(1);
        final all = [...state.events];
        all.addAll(eventRespose.data.toListEntity());
        emit(state.copyWith(
            events: all, isloading: false, page: state.page + 1));
        if (state.page > eventRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _refreshPage(
      Refreshpage event, Emitter<EventState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final eventRespose = await _getEventsUsecase.excecute(1);
        emit(state.copyWith(
            events: eventRespose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        if (state.page > eventRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _clickEvents(
      ClickEvent event, Emitter<EventState> emit) async {
    // appRoute.push(AppRouteInfo.eventDetial());
  }

  FutureOr<void> _clickJoin(ClickJoin evnet, Emitter<EventState> emit) {
    final events = [...state.events];
    EventEntity currectEvent = events[evnet.index];
    events[evnet.index] = currectEvent.copyWith(isJoin: true);

    emit(state.copyWith(events: events));
    // _joinEvent(currectEvent.id);
  }
}
