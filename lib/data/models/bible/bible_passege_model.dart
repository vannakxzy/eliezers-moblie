import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_passage_entity.dart';

part 'bible_passege_model.g.dart';

@JsonSerializable()
class BiblePassegeModel {
  BiblePassegeModel({
    this.id,
    this.content,
    this.reference,
  });
  String? id;
  String? content;
  String? reference;
  factory BiblePassegeModel.fromJson(Map<String, dynamic> json) =>
      _$BiblePassegeModelFromJson(json);
}

extension BiblePassegeModelToEntity on BiblePassegeModel {
  BiblePassageEntity toEntity() => BiblePassageEntity(
        id: id ?? '',
        content: content ?? "",
        reference: reference ?? "",
      );
}
