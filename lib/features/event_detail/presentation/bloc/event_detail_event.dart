part of 'event_detail_bloc.dart';

class EventDetailEvent extends BaseEvent {}

@freezed
class InitPage extends EventDetailEvent with _$InitPage {
  const factory InitPage(EventEntity event) = _InitPage;
}

@freezed
class ClickShare extends EventDetailEvent with _$ClickShare {
  factory ClickShare() = _ClickShare;
}

@freezed
class ClickPlaySong extends EventDetailEvent with _$ClickPlaySong {
  factory ClickPlaySong(int index) = _ClickPlaySong;
}

@freezed
class ClickMusics extends EventDetailEvent with _$ClickMusics {
  factory ClickMusics() = _ClickMusics;
}

@freezed
class ClickJoin extends EventDetailEvent with _$ClickJoin {
  factory ClickJoin(int id) = _ClickJoin;
}

@freezed
class ClickLeave extends EventDetailEvent with _$ClickLeave {
  factory ClickLeave(int id) = _ClickLeave;
}
