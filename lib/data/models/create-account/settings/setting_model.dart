// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../../../../features/setting/domain/entities/setting_entity.dart';
part 'setting_model.g.dart';

@JsonSerializable(createToJson: true)
class SettingModel {
  SettingModel({
    required this.mode,
    required this.languages,
    required this.private_account,
    required this.show_aacl,
    required this.show_answer,
    required this.show_question,
    required this.notification,
    required this.notification_like,
    required this.notification_comment,
    required this.notification_answer,
    required this.notification_correct,
  });
  final bool? mode;
  final String? languages;
  final bool? private_account;
  final bool? show_aacl;
  final bool? show_answer;
  final bool? show_question;
  final bool? notification;
  final bool? notification_like;
  final bool? notification_comment;
  final bool? notification_correct;
  final bool? notification_answer;
  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);
}

extension SettingModelToEntity on SettingModel {
  SettingEntity toEntity() => SettingEntity(
        languages: languages ?? '',
        notification: notification ?? true,
        notification_answer: notification_answer ?? true,
        notification_comment: notification_comment ?? true,
        notification_correct: notification_correct ?? true,
        notification_like: notification_like ?? true,
        private_account: private_account ?? true,
        show_aacl: show_aacl ?? true,
        show_answer: show_answer ?? true,
        show_question: show_question ?? true,
      );
}

extension SettingModelToListEntity on List<SettingModel> {
  List<SettingEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
