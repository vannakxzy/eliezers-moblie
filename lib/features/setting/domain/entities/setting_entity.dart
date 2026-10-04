// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_entity.freezed.dart';

@freezed
class SettingEntity with _$SettingEntity {
  factory SettingEntity({
    @Default('') String languages,
    @Default(true) bool private_account,
    @Default(true) bool show_aacl,
    @Default(true) bool show_answer,
    @Default(true) bool show_question,
    @Default(true) bool notification,
    @Default(true) bool notification_like,
    @Default(true) bool notification_comment,
    @Default(true) bool notification_answer,
    @Default(true) bool notification_correct,
  }) = _SettingEntity;
}
