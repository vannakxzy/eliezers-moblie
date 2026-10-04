import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../post/domain/entities/tag_entity.dart';

part 'question_entity.freezed.dart';
part 'question_entity.g.dart';

@freezed
class QuestionEntity with _$QuestionEntity {
  const factory QuestionEntity({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String name,
    @Default('') String avatar,
    @Default(0) int userId,
    @Default([]) List<TagEntity> tags,
    @Default('') String description,
    @Default(0) int countLike,
    @Default(0) int amountAnswers,
    @Default(0) int amountComments,
    @Default(0) int bandId,
    @Default('') String image,
    @Default('') String date,
    @Default(false) bool is_like,
    @Default(false) bool isHide,
    @Default(false) bool is_saved,
    @Default(false) bool isTrue,
    @Default(false) bool isYourQuestion,
    @Default(false) bool is_discussion,
    @Default(true) bool isEdited,
    @Default('') String visibility,
    @JsonKey(ignore: true) File? file,
    @JsonKey(ignore: true) @Default(false) bool isUpdated,
    @JsonKey(ignore: true) @Default(false) bool isDeleted,
  }) = _QuestionEntity;

  factory QuestionEntity.fromJson(Map<String, dynamic> json) =>
      _$QuestionEntityFromJson(json);
}
