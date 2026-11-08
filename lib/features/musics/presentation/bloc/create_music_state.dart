part of 'create_music_bloc.dart';

@freezed
class CreateMusicState extends BaseState with _$CreateMusicState {
  const factory CreateMusicState.initial({
    @Default('') String title,
    @Default(false) bool isloading,
    @Default('') String artist,
    @Default('') String album,
    @Default('') String genre,
    @Default(0) int duration,
    @Default(0) int bpm,
    @Default('') String lead_sheet,
    @Default('') String chord_sheet,
    File? cover,
    File? audio,
    AudioPlayer? audioPlayer,
    @Default('') String description,
  }) = _Initial;
}
extension CreateMusicStateExt on CreateMusicState {
  bool get canCreate =>
      title.isNotEmpty &&
      description.isNotEmpty &&
      artist.isNotEmpty &&
      chord_sheet.isNotEmpty &&
      lead_sheet.isNotEmpty;
}
