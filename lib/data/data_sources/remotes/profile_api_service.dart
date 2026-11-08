import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/create-account/settings/setting_model.dart';
import '../../models/profile/profile_model.dart';

part 'profile_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class ProfileApiService {
  @FactoryMethod()
  factory ProfileApiService(Dio dio) = _ProfileApiService;
  @GET(ApiEndpoints.findProfile)
  Future<ProfileModel> getOtherProfile(@Query('id') int userId);
  @GET(ApiEndpoints.getSetting)
  Future<SettingModel> getOtherSetting(@Query('id') int userId);
  // owner
  @GET(ApiEndpoints.getSetting)
  Future<SettingModel> getSetting();
  @GET(ApiEndpoints.getProfile)
  Future<ProfileModel> getProfile();
}

@JsonSerializable(createToJson: true)
class UserIdPageInput {
  final int id;
  final int page;
  UserIdPageInput({required this.page, required this.id});
  Map<String, dynamic> toJson() => _$UserIdPageInputToJson(this);
}
