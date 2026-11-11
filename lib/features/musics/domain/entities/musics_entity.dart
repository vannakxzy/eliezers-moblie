import 'package:freezed_annotation/freezed_annotation.dart';

part 'musics_entity.freezed.dart';
part 'musics_entity.g.dart';

@freezed
class MusicsEntity with _$MusicsEntity {
  factory MusicsEntity({
    @Default('') String title,
    @Default('') String artist,
    @Default('') String album,
    @Default('') String genre,
    @Default(0) int duration,
    @Default(0) int bpm,
    @Default('') String description,
    @Default('') String cover,
    @Default('') String audio,
    @Default('') String lyrics,
    @Default(false) bool isFavorite,
    @Default(false) bool isPlay,
    @Default(0) int id,
    @Default(false) bool isSelected,
    @Default('') String chord_sheet,

  }) = _MusicsEntity;
  factory MusicsEntity.fromJson(Map<String, dynamic> json) =>
      _$MusicsEntityFromJson(json);
}
