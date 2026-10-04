part of 'event_detail_bloc.dart';

@freezed
class EventDetailState extends BaseState with _$EventDetailState {
  const factory EventDetailState({
    @Default(EventEntity()) EventEntity event,
    @Default(-1) int playSongIndex,
  }) = _Initial;
}
