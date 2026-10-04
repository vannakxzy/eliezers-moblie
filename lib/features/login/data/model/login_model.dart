import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginModel extends LoginResponseEntity {
  const LoginModel(
      {required super.token, super.isLogin, super.is_scussess, super.name});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}
