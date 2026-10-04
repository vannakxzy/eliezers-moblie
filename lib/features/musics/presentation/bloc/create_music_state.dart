part of 'create_music_bloc.dart';

@freezed
class CreateMusicState extends BaseState with _$CreateMusicState {
  const factory CreateMusicState.initial({
    @Default('') String title,
    @Default('') String artist,
    @Default('') String album,
    @Default('') String genre,
    @Default(0) int duration,
    @Default(0) int bpm,
    @Default('') String key,
    File? cover,
    @Default('') String lyrics,
    @Default('') String description,
  }) = _Initial;
}
