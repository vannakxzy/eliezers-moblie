import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/constants.dart';

import '../../models/create-account/settings/setting_model.dart';

part 'setting_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class SettingApiService {
  @FactoryMethod()
  factory SettingApiService(Dio dio) = _SettingApiService;
  @GET(ApiEndpoints.getSetting)
  Future<SettingModel> getSetting();
  @POST(ApiEndpoints.updateSetting)
  Future<void> updateSetting(@Body() UpdateSettingInput input);
}

@JsonSerializable(createToJson: true)
class UpdateSettingInput {
  final bool private_account;
  final bool show_aacl;
  final bool show_answer;
  final bool show_question;
  final bool notification;
  final bool notification_like;

  final bool notification_comment;
  final bool notification_answer;
  final bool notification_correct;

  UpdateSettingInput({
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
  Map<String, dynamic> toJson() => _$UpdateSettingInputToJson(this);
}
