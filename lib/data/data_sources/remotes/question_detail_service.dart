// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';

import '../../models/question_model.dart';

part 'question_detail_service.g.dart';

@LazySingleton()
@RestApi()
abstract class QuestionDetailService {
  @FactoryMethod()
  factory QuestionDetailService(Dio dio) = _QuestionDetailService;
  @GET("${ApiEndpoints.question}/find")
  Future<QuestionModel> getQuestionById({@Query('id') required int questionId});
  @POST(ApiEndpoints.likeAnswer)
  Future<void> likeAnswer({@Field('answer_id') required int answerId});
  @DELETE(ApiEndpoints.likeAnswer)
  Future<void> unLikeAnswer({@Field('answer_id') required int answerId});
  @PUT(ApiEndpoints.correctAnswer)
  Future<void> correctAnswer({@Query('id') required int answerId});
  @DELETE(ApiEndpoints.question)
  Future<void> deleteQuestion({@Query('id') required int quesitonId});
  @PUT(ApiEndpoints.updateQuestion)
  Future<void> updateQuestion(
    @Body() UpdateQuestionInput body,
  );
}

@JsonSerializable()
class UpdateQuestionInput {
  final String title;
  final String description;
  final List<int> tags;
  final String? image;
  final int id;
  final String visibility;

  UpdateQuestionInput({
    required this.title,
    required this.description,
    required this.tags,
    this.image,
    this.visibility = "public",
    required this.id,
  });
  Map<String, dynamic> toJson() => _$UpdateQuestionInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CorrectCreateAnswerInput {
  final int id;
  final bool is_correc;
  CorrectCreateAnswerInput({
    required this.id,
    required this.is_correc,
  });
  Map<String, dynamic> toJson() => _$CorrectCreateAnswerInputToJson(this);
}
