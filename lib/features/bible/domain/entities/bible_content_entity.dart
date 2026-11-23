import 'package:freezed_annotation/freezed_annotation.dart';

import 'bible_book_chapter_entity.dart';
import 'bible_book_intro_entity.dart';

part 'bible_content_entity.freezed.dart';
part 'bible_content_entity.g.dart';

@freezed
class BibleContentEntity with _$BibleContentEntity {
  const factory BibleContentEntity({
    @Default('') String id,
    @Default('') String title,
    @Default('') String full_title,
    @Default('') String abbreviation,
    @Default('') String canon,
    @Default([]) List<BibleBookChapterEntity> chapters,
    @Default(BibleBookIntroEntity()) BibleBookIntroEntity intro,
  }) = _BibleContentEntity;
  factory BibleContentEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleContentEntityFromJson(json);
}
