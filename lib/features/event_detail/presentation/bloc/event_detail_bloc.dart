import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../event/domain/usecase/delete_event_use_case.dart';
import '../../../event/domain/usecase/join_event_usercase.dart';
import '../../../event/domain/usecase/delete_join_event_usecase.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';
part 'event_detail_bloc.freezed.dart';

@Injectable()
class EventDetailBloc extends BaseBloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc(this._JoinEventUsecase, this._deleteJoinEventUsecase,
      this._deleteEventUseCase)
      : super(const _Initial()) {
    on<InitPage>(_initPage);
    on<ClickJoin>(_clickJoin);
    on<ClickLeave>(_clickLeave);
    on<ClickShare>(_clickShare);
    on<ClickPlaySong>(_clickPlaySond);
    on<ClickDeleteEvent>(_clickDeleteEvent);
  }
  final JoinEventUsecase _JoinEventUsecase;
  final DeleteJoinEventUsecase _deleteJoinEventUsecase;
  final DeleteEventUseCase _deleteEventUseCase;
  FutureOr<void> _initPage(
      InitPage event, Emitter<EventDetailState> emit) async {
    emit(state.copyWith(event: event.event));
  }

  FutureOr<void> _clickDeleteEvent(
      ClickDeleteEvent event, Emitter<EventDetailState> emit) async {
    await runAppCatching(
      () async {
        await _deleteEventUseCase.excecute(event.id).then(
          (value) {
            // emit(state.copyWith(event: state.event.copyWith(isjoin: true)));
          },
        );
      },
    );
    emit(state.copyWith(event: state.event.copyWith(isjoin: true)));
  }

  FutureOr<void> _clickShare(
      ClickShare event, Emitter<EventDetailState> emit) async {
    // await shareQuestion();
  }
  FutureOr<void> _clickJoin(
      ClickJoin event, Emitter<EventDetailState> emit) async {
    await runAppCatching(
      () async {
        await _JoinEventUsecase.excecute(event.id).then(
          (value) {
            emit(state.copyWith(event: state.event.copyWith(isjoin: true)));
          },
        );
      },
    );
    emit(state.copyWith(event: state.event.copyWith(isjoin: true)));
  }


  FutureOr<void> _clickLeave(
      ClickLeave event, Emitter<EventDetailState> emit) async {
    await runAppCatching(
      () async {
        await _deleteJoinEventUsecase.excecute(event.id).then(
          (value) {
            emit(state.copyWith(event: state.event.copyWith(isjoin: false)));
          },
        );
      },
    );
  }

  FutureOr<void> _clickPlaySond(
      ClickPlaySong event, Emitter<EventDetailState> emit) {
    final updateMusic = state.event.musics.asMap().entries.map((entry) {
      final index = entry.key;
      final music = entry.value;
      if (index == event.index) {
        if (!music.isPlay) {}
        return music.copyWith(isPlay: !music.isPlay);
      }
      return music.copyWith(isPlay: false);
    }).toList();
    emit(state.copyWith(event: state.event.copyWith(musics: updateMusic)));
    emit(state.copyWith(playSongIndex: event.index));
  }
}
