import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_passage_entity.freezed.dart';
part 'bible_passage_entity.g.dart';

@freezed
class BiblePassageEntity with _$BiblePassageEntity {
  const factory BiblePassageEntity({
    @Default('') String id,
    @Default('') String content,
    @Default('') String reference,
  }) = _BiblePassageEntity;
  factory BiblePassageEntity.fromJson(Map<String, dynamic> json) =>
      _$BiblePassageEntityFromJson(json);
}
