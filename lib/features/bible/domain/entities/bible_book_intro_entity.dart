import 'package:freezed_annotation/freezed_annotation.dart';
part 'bible_book_intro_entity.freezed.dart';
part 'bible_book_intro_entity.g.dart';

@freezed
class BibleBookIntroEntity with _$BibleBookIntroEntity {
  const factory BibleBookIntroEntity({
    @Default('') String id,
    @Default('') String passage_id,
    @Default('') String title,
  }) = _BibleBookIntroEntity;
  factory BibleBookIntroEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleBookIntroEntityFromJson(json);
}
