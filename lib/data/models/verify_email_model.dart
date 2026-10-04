import 'package:freezed_annotation/freezed_annotation.dart';
import '../../features/verify_email/domain/entity/verify_email_entity.dart';

part 'verify_email_model.g.dart';

@JsonSerializable(createToJson: false)
class VerifyEmailModel extends VerifyEmailEntity {
  const VerifyEmailModel({required super.is_scussess, super.message});

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailModelFromJson(json);
}
