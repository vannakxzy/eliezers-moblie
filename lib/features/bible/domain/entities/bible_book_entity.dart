import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_book_entity.freezed.dart';
part 'bible_book_entity.g.dart';

@freezed
class BibleBookEntity with _$BibleBookEntity {
  const factory BibleBookEntity({
    @Default(0) int id,
    @Default('') String abbreviation,
    @Default('') String promotional_content,
    @Default('') String copyright,
    @Default('') String publisher_name,
    @Default('') String publisher_url,
    @Default('') String language_tag,
    @Default('') String localized_abbreviation,
    @Default('') String localized_title,
    @Default('') String title,
    @Default([]) List<String> books,
    @Default('') String youversion_deep_link,
    @Default('') String organization_id,
  }) = _BibleBookEntity;
  factory BibleBookEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleBookEntityFromJson(json);
}
