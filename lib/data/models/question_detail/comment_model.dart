// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/question_detail/domain/entities/comment_entity.dart';
part 'comment_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CommentModel {
  CommentModel({
    this.date,
    this.id,
    this.message,
    this.name,
    this.user_id,
    this.count_like,
    this.is_like,
    this.avatar,
    this.isPostDone,
    this.is_your,
  });
  final bool? isPostDone;
  final int? id;
  final int? user_id;
  final String? name;
  final String? message;
  final int? count_like;
  final bool? is_like;
  final String? avatar;
  final String? date;
  final bool? is_your;
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

extension CommentModelToEntity on CommentModel {
  CommentEntity toEntity() => CommentEntity(
      is_like: is_like ?? false,
      id: id ?? 0,
      date: date ?? '',
      user_id: user_id ?? 0,
      avatar: avatar ?? "",
      count_like: count_like ?? 0,
      name: name ?? '',
      message: message ?? '',
      is_your: is_your ?? true,
      isPostDone: isPostDone ?? true);
}

extension CommentModelToListEntity on List<CommentModel> {
  List<CommentEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
