// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../features/profile/domain/entities/answer_entity.dart';
part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  AnswerModel({
    required this.amount_comments,
    required this.is_allow,
    required this.date,
    required this.description,
    required this.image,
    required this.count_like,
    required this.is_correct,
    required this.id,
    required this.user_id,
    required this.name,
    required this.avatar,
    required this.question_id,
    required this.is_like,
    required this.is_your,
  });
  final int? amount_comments;
  final bool? is_allow;
  final String? date;
  final String? description;
  final String? image;
  final int? count_like;
  final bool? is_correct;
  final int? id;
  final int? question_id;
  final bool? is_your;
  final int? user_id;
  final String? name;
  final String? avatar;
  final bool? is_like;
  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}

extension AnswerModelToEntity on AnswerModel {
  AnswertEntity toEntity() => AnswertEntity(
      is_like: is_like ?? false,
      amount_comments: amount_comments ?? 0,
      id: id ?? 0,
      image: image ?? "",
      date: date ?? '',
      user_id: user_id ?? 0,
      avatar: avatar ?? "",
      question_id: question_id ?? 0,
      count_like: count_like ?? 0,
      description: description ?? "",
      is_allow: is_allow ?? false,
      is_correct: is_correct ?? false,
      is_your: is_your ?? false,
      name: name ?? "");
}

extension AnswerModelToListEntity on List<AnswerModel> {
  List<AnswertEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
