import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_book_intro_entity.dart';

part 'bible_book_intro_model.g.dart';

@JsonSerializable()
class BibleBookIntroModel {
  BibleBookIntroModel({
    this.id,
    this.passage_id,
    this.title,
  });

  String? id;
  String? passage_id;
  String? title;

  factory BibleBookIntroModel.fromJson(Map<String, dynamic> json) =>
      _$BibleBookIntroModelFromJson(json);
}

extension BibleBookIntroModelToEntity on BibleBookIntroModel {
  BibleBookIntroEntity toEntity() => BibleBookIntroEntity(
        id: id ?? '',
        passage_id: passage_id ?? '',
        title: title ?? '',
      );
}
