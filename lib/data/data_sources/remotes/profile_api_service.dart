import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/homes/question_respose_model.dart';
import '../../models/profile/answer_respose_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/create-account/settings/setting_model.dart';
import '../../models/profile/profile_model.dart';
import '../../models/profile/top_tag_model.dart';

part 'profile_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class ProfileApiService {
  @FactoryMethod()
  factory ProfileApiService(Dio dio) = _ProfileApiService;
  @GET(ApiEndpoints.findProfile)
  Future<ProfileModel> getOtherProfile(@Query('id') int userId);
  @GET(ApiEndpoints.getQuestionByUser)
  Future<QuestionResposeModel> getOtherQuestion(
      {@Body() required UserIdPageInput input});
  @GET(ApiEndpoints.getAnswerByUser)
  Future<AnswerResposeModel> getOtherAnswer(
      {@Body() required UserIdPageInput input});
  @GET(ApiEndpoints.getTopTag)
  Future<List<TopTagModel>> getOtherTopTag(@Query('id') int userId);
  @GET(ApiEndpoints.getSetting)
  Future<SettingModel> getOtherSetting(@Query('id') int userId);
  // owner
  @GET(ApiEndpoints.getSetting)
  Future<SettingModel> getSetting();
  @GET(ApiEndpoints.getProfile)
  Future<ProfileModel> getProfile();
  @GET(ApiEndpoints.getQuestionByUser)
  Future<QuestionResposeModel> getQuestion(@Query('page') int page);
  @GET(ApiEndpoints.getAnswerByUser)
  Future<AnswerResposeModel> getAnswer(@Query('page') int page);
  @GET(ApiEndpoints.getTopTag)
  Future<List<TopTagModel>> getTopTag();
}

@JsonSerializable(createToJson: true)
class UserIdPageInput {
  final int id;
  final int page;
  UserIdPageInput({required this.page, required this.id});
  Map<String, dynamic> toJson() => _$UserIdPageInputToJson(this);
}
