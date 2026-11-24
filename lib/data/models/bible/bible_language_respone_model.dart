import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_language_entity.dart';
import 'bible_language_model.dart';

part 'bible_language_respone_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BibleLanguageResponeModel {
  BibleLanguageResponeModel({
    this.data = const [],
  });

  final List<BibleLanguageModel> data;

  factory BibleLanguageResponeModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BibleLanguageResponeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BibleLanguageResponeModelToJson(this);

  List<BibleLanguageEntity> toListEntity() =>
      data.map((model) => model.toEntity()).toList();
}
