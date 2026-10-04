import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/homes/question_respose_model.dart';
import '../../models/profile/answer_respose_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/constants.dart';

part 'data_tag_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class DataTagApiService {
  @FactoryMethod()
  factory DataTagApiService(Dio dio) = _DataTagApiService;
  @GET(ApiEndpoints.getOtherQuestionByTag)
  Future<QuestionResposeModel> getOtherQuestionByTag(
      {@Body() required UserIdTagIdInput input});
  @GET(ApiEndpoints.getOtherAnswerByTag)
  Future<AnswerResposeModel> getOtherAnswerByTag(
      {@Body() required UserIdTagIdInput input});
  @GET(ApiEndpoints.getOwnQuestionByTag)
  Future<QuestionResposeModel> getOwnQuestionByTag(
      {@Body() required TagIdInput input});
  @GET(ApiEndpoints.getOwnAnswerByTag)
  Future<AnswerResposeModel> getOwnAnswerByTag(
      {@Body() required TagIdInput input});
}

@JsonSerializable(createToJson: true)
class TagIdInput {
  final int page;
  final int tag_id;
  TagIdInput({required this.tag_id, required this.page});
  Map<String, dynamic> toJson() => _$TagIdInputToJson(this);
}

@JsonSerializable(createToJson: true)
class UserIdTagIdInput {
  final int page;
  final int tag_id;
  final int user_id;
  UserIdTagIdInput(
      {required this.tag_id, required this.user_id, required this.page});
  Map<String, dynamic> toJson() => _$UserIdTagIdInputToJson(this);
}
