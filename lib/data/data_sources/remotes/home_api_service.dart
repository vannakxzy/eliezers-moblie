// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../app/base/response/base_data_response.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/constants.dart';
import '../../models/homes/question_respose_model.dart';
import '../../models/subject_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/question_model.dart';

part 'home_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class HomeApiService {
  @FactoryMethod()
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(ApiEndpoints.question)
  Future<QuestionResposeModel> getAllHomeQuestion(
      @Body() GetQuestionInput input);
  @GET("${ApiEndpoints.question}/count-result")
  Future<int> countResult(@Body() GetQuestionInput input);
  @GET(ApiEndpoints.getMySubject)
  Future<DataResponse<List<SubjectModel>>> GetSubjectEvent();

  @GET('${ApiEndpoints.getQuestionBySubject}/{id}')
  Future<DataResponse<List<QuestionModel>>> getQuestionBySubject(
      @Path("id") int id);

  @POST(ApiEndpoints.likeQuestion)
  Future<void> likeQuestion(@Query('question_id') int id);

  @DELETE(ApiEndpoints.unLikeQuestion)
  Future<void> unLikeQuestion(@Query('question_id') int id);

  @POST(ApiEndpoints.postDeviceToken)
  Future<void> postDeviceToken(
      @Body() PostDeviceTokenInput postDeviceTokenInput);
}

@JsonSerializable(createToJson: true)
class PostDeviceTokenInput {
  final String device_token;
  PostDeviceTokenInput({
    required this.device_token,
  });
  Map<String, dynamic> toJson() => _$PostDeviceTokenInputToJson(this);
}

@JsonSerializable(createToJson: true)
class GetQuestionInput {
  @JsonKey(defaultValue: '')
  final String like;

  @JsonKey(defaultValue: [])
  final List<int> tags;

  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(defaultValue: 1)
  final int page;
  final int band_id;
  @JsonKey(defaultValue: '')
  final String date;
  final String type;

  GetQuestionInput(
      {this.like = '',
      this.tags = const [],
      this.status = '',
      this.page = 1,
      this.date = '',
      this.type = '',
      this.band_id = 0});

  Map<String, dynamic> toJson() => _$GetQuestionInputToJson(this);

  factory GetQuestionInput.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionInputFromJson(json);
}
