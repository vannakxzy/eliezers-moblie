// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../question_detail/domain/entities/comment_entity.dart';

part 'answer_entity.freezed.dart';
part 'answer_entity.g.dart';

@freezed
class AnswertEntity with _$AnswertEntity {
  factory AnswertEntity({
    @Default(-1) int id,
    @Default(0) int user_id,
    @Default('') String name,
    @Default('') String avatar,
    @Default('') String description,
    @Default('') String image,
    @Default(0) int question_id,
    @Default(0) int amount_comments,
    @Default(0) int count_like,
    @Default(false) bool is_like,
    @Default(false) bool is_correct,
    @Default(false) bool is_allow,
    @Default(false) bool is_your,
    @Default('') String date,
    @JsonKey(ignore: true) File? file,
    @JsonKey(ignore: true) @Default([]) List<CommentEntity> comments,
    @Default(false) bool showComment,
    @Default(true) bool isPostDone,
    @Default(true) bool isEditDone,
  }) = _AnswertEntity;
  factory AnswertEntity.fromJson(Map<String, dynamic> json) =>
      _$AnswertEntityFromJson(json);
}
