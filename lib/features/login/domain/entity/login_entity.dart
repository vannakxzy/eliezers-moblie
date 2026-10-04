import 'package:json_annotation/json_annotation.dart';

class LoginResponseEntity {
  const LoginResponseEntity(
      {required this.token,
      this.isLogin = false,
      this.is_scussess = true,
      this.name = ""});
  final bool is_scussess;
  @JsonKey(name: 'access_token')
  final String token;
  @JsonKey(name: 'is_login')
  final bool isLogin;
  final String name;
}
