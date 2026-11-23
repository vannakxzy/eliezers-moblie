import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_book_chapter_entity.dart';
import 'bible_book_verse_model.dart';

part 'bible_book_chapter_model.g.dart';

@JsonSerializable()
class BibleBookChapterModel {
  BibleBookChapterModel({
    this.id,
    this.passage_id,
    this.title,
    this.verses,
  });

  String? id;
  String? passage_id;
  String? title;
  List<BibleBookVerseModel>? verses;

  factory BibleBookChapterModel.fromJson(Map<String, dynamic> json) =>
      _$BibleBookChapterModelFromJson(json);
}

extension BibleBookChapterModelToEntity on BibleBookChapterModel {
  BibleBookChapterEntity toEntity() => BibleBookChapterEntity(
        id: id ?? '',
        passage_id: passage_id ?? '',
        title: title ?? '',
        verses: verses?.toListEntity() ?? [],
      );
}

extension BibleBookChapterModelListToEntity on List<BibleBookChapterModel> {
  List<BibleBookChapterEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
