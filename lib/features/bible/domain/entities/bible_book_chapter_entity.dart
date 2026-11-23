import 'package:freezed_annotation/freezed_annotation.dart';

import 'bible_book_verse_entity.dart';
part 'bible_book_chapter_entity.freezed.dart';
part 'bible_book_chapter_entity.g.dart';

@freezed
class BibleBookChapterEntity with _$BibleBookChapterEntity {
  const factory BibleBookChapterEntity({
    @Default('') String id,
    @Default('') String passage_id,
    @Default('') String title,
    @Default([]) List<BibleBookVerseEntity> verses,
  }) = _BibleBookChapterEntity;
  factory BibleBookChapterEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleBookChapterEntityFromJson(json);
}
