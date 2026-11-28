part of 'edit_music_bloc.dart';

@freezed
class EditMusicState extends BaseState with _$EditMusicState {
  const factory EditMusicState.initial({
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
    @Default('') String coverUrl,
    @Default('') String musicUrl,
  }) = _Initial;
}

extension EditMusicStateExt on EditMusicState {
  bool get canUpdate =>
      title.isNotEmpty && artist.isNotEmpty && chord_sheet.isNotEmpty;
  EditMusicState cleardAll() => copyWith(
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
