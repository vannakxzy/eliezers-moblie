import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_book_verse_entity.dart';

part 'bible_book_verse_model.g.dart';

@JsonSerializable()
class BibleBookVerseModel {
  BibleBookVerseModel({
    this.id,
    this.passage_id,
    this.title,
  });

  String? id;
  String? passage_id;
  String? title;

  factory BibleBookVerseModel.fromJson(Map<String, dynamic> json) =>
      _$BibleBookVerseModelFromJson(json);
}

extension BibleBookVerseModelToEntity on BibleBookVerseModel {
  BibleBookVerseEntity toEntity() => BibleBookVerseEntity(
        id: id ?? '',
        passage_id: passage_id ?? '',
        title: title ?? '',
      );
}

extension BibleBookVerseModelListToEntity on List<BibleBookVerseModel> {
  List<BibleBookVerseEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
