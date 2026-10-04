part of 'event_bloc.dart';

@freezed
class EventState extends BaseState with _$EventState {
  const factory EventState({
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default([]) List<EventEntity> events,
    @Default(true) bool isloading,
  }) = _EventState;
}
