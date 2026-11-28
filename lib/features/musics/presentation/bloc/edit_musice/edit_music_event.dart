part of 'edit_music_bloc.dart';

class EditMusicEvent extends BaseEvent {}

@freezed
class TitleChange extends EditMusicEvent with _$TitleChange {
  factory TitleChange(String value) = _TitleChange;
}

@freezed
class InitPage extends EditMusicEvent with _$InitPage {
  factory InitPage(MusicsEntity music) = _InitPage;
}

@freezed
class ArtistChange extends EditMusicEvent with _$ArtistChange {
  factory ArtistChange(String value) = _ArtistChange;
}

@freezed
class AlbumChange extends EditMusicEvent with _$AlbumChange {
  factory AlbumChange(String value) = _AlbumChange;
}

@freezed
class GenreChange extends EditMusicEvent with _$GenreChange {
  factory GenreChange(String value) = _GenreChange;
}

@freezed
class DurationChange extends EditMusicEvent with _$DurationChange {
  factory DurationChange(int value) = _DurationChange;
}

@freezed
class BpmChange extends EditMusicEvent with _$BpmChange {
  factory BpmChange(int value) = _BpmChange;
}

@freezed
class KeyChange extends EditMusicEvent with _$KeyChange {
  factory KeyChange(String value) = _KeyChange;
}

@freezed
class CoverChange extends EditMusicEvent with _$CoverChange {
  factory CoverChange(File value) = _CoverChange;
}

@freezed
class ClickUpdate extends EditMusicEvent with _$ClickUpdate {
  factory ClickUpdate(int id) = _ClickUpdate;
}

@freezed
class LyricsChange extends EditMusicEvent with _$LyricsChange {
  factory LyricsChange(String value) = _LyricsChange;
}

@freezed
class DescriptionChange extends EditMusicEvent with _$DescriptionChange {
  factory DescriptionChange(String value) = _DescriptionChange;
}

@freezed
class AudioChange extends EditMusicEvent with _$AudioChange {
  factory AudioChange(PlatformFile value) = _AudioChange;
}

@freezed
class UpdateSelectedMusics extends EditMusicEvent with _$UpdateSelectedMusics {
  factory UpdateSelectedMusics(List<MusicsEntity> data) = _UpdateSelectedMusics;
}

@freezed
class ChordsheetChange extends EditMusicEvent with _$ChordsheetChange {
  factory ChordsheetChange(String value) = _ChordsheetChange;
}
