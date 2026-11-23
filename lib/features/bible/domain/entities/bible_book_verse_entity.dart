import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_book_verse_entity.freezed.dart';
part 'bible_book_verse_entity.g.dart';

@freezed
class BibleBookVerseEntity with _$BibleBookVerseEntity {
  const factory BibleBookVerseEntity({
    @Default('') String id,
    @Default('') String passage_id,
    @Default('') String title,
  }) = _BibleBookVerseEntity;
  factory BibleBookVerseEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleBookVerseEntityFromJson(json);
}
