import 'package:json_annotation/json_annotation.dart';

class VerifyEmailEntity {
  const VerifyEmailEntity({required this.is_scussess, this.message = ''});

  @JsonKey(name: 'is_scussess')
  final bool is_scussess;
  @JsonKey(name: 'message')
  final String message;
}
