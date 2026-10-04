// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'post_question/tag_model.dart';

import '../../features/home/domain/entities/question_entity.dart';
part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  QuestionModel(
      {required this.is_true,
      required this.id,
      required this.band_id,
      required this.title,
      required this.description,
      required this.user_id,
      required this.name,
      required this.avatar,
      required this.count_like,
      required this.amount_answers,
      required this.amount_comments,
      required this.date,
      required this.image,
      required this.is_like,
      required this.is_your,
      required this.tags,
      required this.is_saved,
      required this.visibility,
      required this.is_discussion});
  final int? id;
  final String? title;
  final String? name;
  final String? avatar;
  final bool? is_saved;
  final bool? is_discussion;
  final int? user_id;
  final List<TagModel>? tags;
  final String? description;
  final int? count_like;
  final int? amount_answers;
  final int? amount_comments;
  final String? image;
  final String? date;
  final bool? is_like;
  final bool? is_true;
  final bool? is_your;
  final String? visibility;
  final int? band_id;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

extension QuestionModelToEntity on QuestionModel {
  QuestionEntity toEntity() => QuestionEntity(
      visibility: visibility ?? "",
      amountComments: amount_comments ?? 0,
      amountAnswers: amount_answers ?? 0,
      avatar: avatar ?? "",
      countLike: count_like ?? 0,
      date: date ?? "",
      bandId: band_id ?? 0,
      description: description ?? "",
      id: id ?? 0,
      image: image ?? "",
      name: name ?? "",
      isYourQuestion: is_your ?? false,
      tags: tags!.toListEntity(),
      title: title ?? "",
      is_like: is_like ?? false,
      userId: user_id ?? 0,
      isTrue: is_true ?? false,
      is_discussion: is_discussion ?? false,
      is_saved: is_saved ?? false);
}

extension QuestionModelToListEntity on List<QuestionModel> {
  List<QuestionEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
