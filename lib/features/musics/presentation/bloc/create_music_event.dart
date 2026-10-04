part of 'create_music_bloc.dart';

class CreateMusicEvent extends BaseEvent {}

@freezed
class TitleChange extends CreateMusicEvent with _$TitleChange {
  factory TitleChange(String value) = _TitleChange;
}

@freezed
class ArtistChange extends CreateMusicEvent with _$ArtistChange {
  factory ArtistChange(String value) = _ArtistChange;
}

@freezed
class AlbumChange extends CreateMusicEvent with _$AlbumChange {
  factory AlbumChange(String value) = _AlbumChange;
}

@freezed
class GenreChange extends CreateMusicEvent with _$GenreChange {
  factory GenreChange(String value) = _GenreChange;
}

@freezed
class DurationChange extends CreateMusicEvent with _$DurationChange {
  factory DurationChange(int value) = _DurationChange;
}

@freezed
class BpmChange extends CreateMusicEvent with _$BpmChange {
  factory BpmChange(int value) = _BpmChange;
}

@freezed
class KeyChange extends CreateMusicEvent with _$KeyChange {
  factory KeyChange(String value) = _KeyChange;
}

@freezed
class CoverChange extends CreateMusicEvent with _$CoverChange {
  factory CoverChange(File value) = _CoverChange;
}

@freezed
class LyricsChange extends CreateMusicEvent with _$LyricsChange {
  factory LyricsChange(String value) = _LyricsChange;
}

@freezed
class DescriptionChange extends CreateMusicEvent with _$DescriptionChange {
  factory DescriptionChange(String value) = _DescriptionChange;
}
