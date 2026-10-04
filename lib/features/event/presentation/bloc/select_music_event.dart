part of 'select_music_bloc.dart';

class SelectMusicEvent extends BaseEvent {}

@freezed
class Seaching extends SelectMusicEvent with _$Seaching {
  factory Seaching(int index) = _Seaching;
}
