import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/verify_email_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';

part 'verify_email_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class VerifyEmailApiService {
  @FactoryMethod()
  factory VerifyEmailApiService(Dio dio) = _VerifyEmailApiService;
  @POST(ApiEndpoints.sendOtp)
  Future<void> sendOtp({@Body() required VerifyOtpInput input});
  @POST(ApiEndpoints.verifyOtp)
  Future<VerifyEmailModel> verifyOtp(
      {@Body() required VerifyOtpInput verifyOtpInput});
}

@JsonSerializable(createToJson: true)
class VerifyOtpInput {
  final String? email;
  final String? otp;
  VerifyOtpInput({
    this.email,
    this.otp,
  });
  factory VerifyOtpInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpInputFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpInputToJson(this);
}
