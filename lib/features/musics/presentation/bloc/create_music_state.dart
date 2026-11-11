part of 'create_music_bloc.dart';

@freezed
class CreateMusicState extends BaseState with _$CreateMusicState {
  const factory CreateMusicState.initial({
    @Default('') String title,
    @Default(false) bool isloading,
    @Default('') String artist,
    @Default('') String album,
    @Default('') String genre,
    @Default('') String timeMusic,
    TextEditingController? titleCon,
    TextEditingController? artistCon,
    TextEditingController? chordSheetCon,

    @Default(0) int duration,
    @Default(0) int bpm,
    @Default('') String lead_sheet,
    @Default('') String chord_sheet,
    File? cover,
    File? audio,
    AudioPlayer? audioPlayer,
    PlatformFile? platformFile,
    @Default('') String description,
  }) = _Initial;
}
extension CreateMusicStateExt on CreateMusicState {
  bool get canCreate =>
      title.isNotEmpty &&
      artist.isNotEmpty &&
      chord_sheet.isNotEmpty &&
      timeMusic.isNotEmpty;
  CreateMusicState cleardAll() => copyWith(
      title: "",
      artist: "",
      chord_sheet: "",
      cover: null,
      artistCon: TextEditingController(),
      titleCon: TextEditingController(),
      chordSheetCon: TextEditingController(),
      timeMusic: "",
      audio: null,
      audioPlayer: null);
}
