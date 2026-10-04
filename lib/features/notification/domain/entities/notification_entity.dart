import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/profile/answer_model.dart';
import 'user_entity.dart';

part 'notification_entity.freezed.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  factory NotificationEntity({
    @Default(0) int id,
    @Default('') String type,
    @Default(0) int questionId,
    @Default('') String message,
    @Default(0) int commentId,
    @Default(0) int answerId,
    @Default('') String date,
    @Default('') String status,
    @Default('') String bandName,
    @Default(0) int bandId,
    @Default(false) bool readAt,
    AnswerModel? answer,
    UserEntity? user,
  }) = _NotificationEntity;
}
