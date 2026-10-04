import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/question_detail/comment_respose_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/question_detail/comment_model.dart';

part 'comment_in_answer_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class CommentInAnswerApiService {
  @FactoryMethod()
  factory CommentInAnswerApiService(Dio dio) = _CommentInAnswerApiService;
  @POST(ApiEndpoints.createComment)
  Future<CommentModel> createCommentInAnswer(
      {@Body() required CreateCommnetInAnswer createCommnetInAnswer});
  @GET(ApiEndpoints.getCommnetInQuestion)
  Future<CommentResposeModel> getCommentInAnswer(
      {@Body() required GetCommentAnswerInput input});
}

@JsonSerializable(createToJson: true)
class GetCommentAnswerInput {
  final int answer_id;
  final int page;
  GetCommentAnswerInput({
    required this.page,
    required this.answer_id,
  });
  Map<String, dynamic> toJson() => _$GetCommentAnswerInputToJson(this);
}

@JsonSerializable(createToJson: true)
class CreateCommnetInAnswer {
  final int answer_id;
  final String message;
  final int band_id;
  CreateCommnetInAnswer({
    required this.message,
    required this.band_id,
    required this.answer_id,
  });
  Map<String, dynamic> toJson() => _$CreateCommnetInAnswerToJson(this);
}
