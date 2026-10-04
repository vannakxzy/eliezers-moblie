import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../../features/login/data/model/login_model.dart';

part 'forgot_password_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class ForgotPasswordApiService {
  @FactoryMethod()
  factory ForgotPasswordApiService(Dio dio) = _ForgotPasswordApiService;
  @POST(ApiEndpoints.createNewPassword)
  Future<LoginModel> createNewPassword(
      {@Body() required CreateNewPassWordInput createNewPassWordInput});
}

@JsonSerializable(createToJson: true)
class CreateNewPassWordInput {
  final String email;
  final String new_password;
  final String model;
  final String otp;
  CreateNewPassWordInput(
      {required this.email,
      required this.new_password,
      required this.model,
      required this.otp});
  Map<String, dynamic> toJson() => _$CreateNewPassWordInputToJson(this);
}
