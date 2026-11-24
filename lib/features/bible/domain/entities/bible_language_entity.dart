import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_language_entity.freezed.dart';
part 'bible_language_entity.g.dart';

@freezed
class BibleLanguageEntity with _$BibleLanguageEntity {
  const factory BibleLanguageEntity({
    @Default('') String id,
    @Default('') String language,
    @Default('') String script,
    @Default('') String script_name,
    @Default([]) List<String> aliases,
    @Default({}) Map<String, String> display_names,
    @Default('') String localized_name,
    @Default([]) List<String> scripts,
    @Default([]) List<String> variants,
    @Default([]) List<String> countries,
    @Default('') String text_direction,
    @Default(0) int writing_population,
    @Default(0) int speaking_population,
    int? default_bible_id,
  }) = _BibleLanguageEntity;

  factory BibleLanguageEntity.fromJson(Map<String, dynamic> json) =>
      _$BibleLanguageEntityFromJson(json);
}
