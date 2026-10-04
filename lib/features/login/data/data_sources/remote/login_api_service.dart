import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../data/data_sources/remotes/create_account_api_service.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/login_model.dart';

import '../../../../../core/constants/api_constants.dart';

part 'login_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class LoginApiService {
  @FactoryMethod()
  factory LoginApiService(Dio dio) = _LoginApiService;

  @POST(ApiEndpoints.login)
  Future<LoginModel> login({@Body() required LoginInput input});
  @POST(ApiEndpoints.checkUser)
  Future<void> checkUser(@Body() CheckUserInput input);
  @POST(ApiEndpoints.authWithGoogle)
  Future<LoginModel> authWithGoogle(
      {@Body() required CreateAccountInput input});
}

@JsonSerializable(createToJson: true)
class LoginInput {
  LoginInput({
    required this.email,
    required this.device_token,
    required this.password,
    required this.manufacturer,
    required this.model,
    required this.otp,
    required this.name,
  });

  final String email;
  final String password;
  final String device_token;
  final String manufacturer;
  final String model;
  final String otp;
  final String? name;

  Map<String, dynamic> toJson() => _$LoginInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CheckUserInput {
  CheckUserInput({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String? name;
  Map<String, dynamic> toJson() => _$CheckUserInputToJson(this);
}
