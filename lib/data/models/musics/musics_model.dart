import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/musics/domain/entities/musics_entity.dart';

part 'musics_model.g.dart';

@JsonSerializable()
class MusicsModel {
  MusicsModel({this.title, this.cover, this.audio, this.id, this.isFavorite});
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

  @Default(false)
  @JsonKey(name: "is_favorite")
  final bool? isFavorite;

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
      );
}

extension QuestionModelToListEntity on List<MusicsModel> {
  List<MusicsEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
