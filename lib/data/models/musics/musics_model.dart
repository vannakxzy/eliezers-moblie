import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/musics/domain/entities/musics_entity.dart';

part 'musics_model.g.dart';

@JsonSerializable()
class MusicsModel {
  MusicsModel({
    this.title,
    this.cover,
    this.description,
    this.bpm,
    this.lyrics,
    this.audio,
    this.id,
    this.isFavorite,
    this.artist,
    this.duration,
  });
  final int? id;
  @Default('')
  @JsonKey(name: 'title')
  final String? title;
  @Default('')
  @JsonKey(name: 'cover')
  final String? cover;
  @Default('')
  @JsonKey(name: 'audio')
  final String? audio;
  @JsonKey(name: 'artist')
  final String? artist;
  @Default(false)
  @JsonKey(name: "is_favorite")
  final bool? isFavorite;
  final String? lyrics;
  final String? description;
  final int? duration;
  final int? bpm;

  factory MusicsModel.fromJson(Map<String, dynamic> json) =>
      _$MusicsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MusicsModelToJson(this);
}

extension MusicsModelnEntity on MusicsModel {
  MusicsEntity toEntity() => MusicsEntity(
        audio: audio ?? "",
        cover: cover ?? "",
        title: title ?? "",
        id: id ?? 0,
        isFavorite: isFavorite ?? false,
      description: description ?? "",
      artist: artist ?? "",
      duration: duration ?? 0,
      bpm: bpm ?? 0
      );
}

extension QuestionModelToListEntity on List<MusicsModel> {
  List<MusicsEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
