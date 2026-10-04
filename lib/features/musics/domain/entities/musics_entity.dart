import 'package:freezed_annotation/freezed_annotation.dart';

part 'musics_entity.freezed.dart';
part 'musics_entity.g.dart';

@freezed
class MusicsEntity with _$MusicsEntity {
  factory MusicsEntity({
    @Default('') String title,
    @Default('') String cover,
    @Default('') String audio,
    @Default(false) bool isFavorite,
    @Default(0) int id,
  }) = _MusicsEntity;
  factory MusicsEntity.fromJson(Map<String, dynamic> json) =>
      _$MusicsEntityFromJson(json);
}
