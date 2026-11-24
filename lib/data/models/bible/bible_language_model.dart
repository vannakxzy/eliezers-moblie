import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/bible/domain/entities/bible_language_entity.dart';

part 'bible_language_model.freezed.dart';
part 'bible_language_model.g.dart';

@freezed
class BibleLanguageModel with _$BibleLanguageModel {
  const BibleLanguageModel._();

  const factory BibleLanguageModel({
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
  }) = _BibleLanguageModel;

  factory BibleLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$BibleLanguageModelFromJson(json);

  BibleLanguageEntity toEntity() => BibleLanguageEntity(
        id: id,
        language: language,
        script: script,
        script_name: script_name,
        aliases: aliases,
        display_names: display_names,
        localized_name: localized_name,
        scripts: scripts,
        variants: variants,
        countries: countries,
        text_direction: text_direction,
        writing_population: writing_population,
        speaking_population: speaking_population,
        default_bible_id: default_bible_id,
      );
}
