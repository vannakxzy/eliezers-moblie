import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/profile/answer_respose_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/profile/answer_model.dart';

part 'answer_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class AnswerApiService {
  @FactoryMethod()
  factory AnswerApiService(Dio dio) = _AnswerApiService;

  @GET(ApiEndpoints.getAnswerInQuestion)
  Future<AnswerResposeModel> getAnswer({@Body() required GetAnswerInput input});
  @POST(ApiEndpoints.answer)
  Future<AnswerModel> createAnswer({@Body() required CreateAnswerInput input});
  @DELETE(ApiEndpoints.answer)
  Future<void> deleteAnswer({@Query('id') required int id});

  @POST(ApiEndpoints.likeAnswer)
  Future<void> likeAnswer({@Query('answer_id') required int answerId});

  @PUT(ApiEndpoints.answer)
  Future<AnswerModel> updateAnswer(
      {@Body() required UpdateAnswerInput answerInput});
}

@JsonSerializable(createToJson: true)
class GetAnswerInput {
  final int question_id;
  final int page;
  GetAnswerInput({
    required this.question_id,
    required this.page,
  });
  Map<String, dynamic> toJson() => _$GetAnswerInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CreateAnswerInput {
  final int question_id;
  final String description;
  final String image;
  final int band_id;
  CreateAnswerInput(
      {required this.description,
      required this.question_id,
      required this.image,
      required this.band_id});
  Map<String, dynamic> toJson() => _$CreateAnswerInputToJson(this);
}

@JsonSerializable(createToJson: true)
class UpdateAnswerInput {
  final int id;
  final String description;
  final String image;
  UpdateAnswerInput({
    required this.description,
    required this.id,
    required this.image,
  });
  Map<String, dynamic> toJson() => _$UpdateAnswerInputToJson(this);
}
