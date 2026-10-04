import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';

@freezed
class CommentEntity with _$CommentEntity {
  factory CommentEntity({
    @Default(0) int id,
    @Default(0) int user_id,
    @Default('') String name,
    @Default('') String message,
    @Default(0) int count_like,
    @Default(false) bool is_like,
    @Default(true) bool is_your,
    @Default(true) bool isPostDone,
    @Default(true) bool isEditDone,
    @Default('') String avatar,
    @Default('') String date,
  }) = _CommentEntity;
}
