part of 'select_music_bloc.dart';

class SelectMusicEvent extends BaseEvent {}

@freezed
class Seaching extends SelectMusicEvent with _$Seaching {
  factory Seaching(String text ) = _Seaching;
}

@freezed
class ClickSelected extends SelectMusicEvent with _$ClickSelected {
  factory ClickSelected(int index) = _ClickSelected;
}

@freezed
class ClickUnSelected extends SelectMusicEvent with _$ClickUnSelected {
  factory ClickUnSelected(int index) = _ClickUnSelected;
}
