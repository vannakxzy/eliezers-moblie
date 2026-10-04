import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';
import '../profile/answer_model.dart';
import '../../../features/notification/domain/entities/notification_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable(createToJson: true)
class NotificationModel {
  NotificationModel(
      {this.answer_id,
      this.comment_id,
      this.question_id,
      this.message,
      this.bandId,
      this.id,
      this.band_name,
      this.read_at,
      this.date,
      this.answer,
      this.user,
      this.type});

  final int? answer_id;
  final int? comment_id;
  final int? question_id;

  @JsonKey(name: 'band_id')
  final int? bandId;
  final String? message;
  final bool? read_at;
  final String? date;
  final int? id;
  final String? type;
  final UserModel? user;
  final AnswerModel? answer;
  final String? band_name;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

extension SubjectModelToEntity on NotificationModel {
  NotificationEntity toEntity() => NotificationEntity(
      answerId: answer_id ?? 0,
      commentId: comment_id ?? 0,
      date: date ?? "",
      answer: answer,
      message: message ?? "",
      questionId: question_id ?? 0,
      readAt: read_at ?? false,
      type: type ?? "",
      bandId: bandId ?? 0,
      id: id ?? 0,
      bandName: band_name ?? '',
      user: user);
}

extension SubjectModelToListEntity on List<NotificationModel> {
  List<NotificationEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
