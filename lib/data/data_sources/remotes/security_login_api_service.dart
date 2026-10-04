import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/security_login/block_respose_model.dart';
import '../../models/security_login/hide_respose_model.dart';
import '../../../features/login/data/model/login_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/constants.dart';

import '../../models/security_login/active_session_model.dart';
part 'security_login_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class SecurityLoginApiService {
  @FactoryMethod()
  factory SecurityLoginApiService(Dio dio) = _SecurityLoginApiService;
  @GET(ApiEndpoints.block)
  Future<BlockResposeModel> getBlock({@Query('page') required int page});
  @DELETE(ApiEndpoints.unBlock)
  Future<void> unBlock(@Query('id') int id);
  @POST(ApiEndpoints.createBlock)
  Future<void> createBlock(@Query('block_id') int id);
  @GET(ApiEndpoints.hide)
  Future<HideResposeModel> getHide({@Query('page') required int page});
  @GET(ApiEndpoints.activeSession)
  Future<List<ActiveSessionModel>> getActiveSession();
  @DELETE(ApiEndpoints.activeSession)
  Future<void> deleteActiveSession({@Query('id') required int id});
  @DELETE(ApiEndpoints.deleteOtherSession)
  Future<void> deleteOtherSession();
  @DELETE(ApiEndpoints.unHide)
  Future<void> unHide(@Query('id') int id);
  @DELETE(ApiEndpoints.unHideByQuestionId)
  Future<void> unHideByQuestionId(@Query('id') int id);
  @POST(ApiEndpoints.createhide)
  Future<void> createHide(@Body() QuestionIdInput quesitonId);
  @PUT(ApiEndpoints.changePassword)
  Future<LoginModel> changePassword(@Query('new_password') String input);
  @DELETE(ApiEndpoints.user)
  Future<void> deleteAccount();
  @POST(ApiEndpoints.logout)
  Future<void> logout();
}

@JsonSerializable(createToJson: true)
class QuestionIdInput {
  final int question_id;
  QuestionIdInput({
    required this.question_id,
  });
  Map<String, dynamic> toJson() => _$QuestionIdInputToJson(this);
}

@JsonSerializable(createToJson: true)
class ChangePassowordInput {
  final String current_password;
  final String new_password;
  ChangePassowordInput({
    required this.current_password,
    required this.new_password,
  });
  Map<String, dynamic> toJson() => _$ChangePassowordInputToJson(this);
}
