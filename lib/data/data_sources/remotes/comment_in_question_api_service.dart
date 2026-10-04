import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/question_detail/comment_respose_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/question_detail/comment_model.dart';

part 'comment_in_question_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class CommentInQuestionApiService {
  @FactoryMethod()
  factory CommentInQuestionApiService(Dio dio) = _CommentInQuestionApiService;
  @POST(ApiEndpoints.createComment)
  Future<CommentModel> createComment(
      {@Body() required CommentInput commentInput});
  @GET(ApiEndpoints.getCommnetInQuestion)
  Future<CommentResposeModel> getCommentInQuestion(
      {@Body() required GetCommentInQuestionInput input});
  @POST(ApiEndpoints.likeComment)
  Future<void> likeComment({@Field('comment_id') required int commentId});
  @DELETE(ApiEndpoints.likeComment)
  Future<void> unLikeComment({@Field('comment_id') required int commentId});
  @DELETE(ApiEndpoints.deleteComment)
  Future<void> deleteComment({@Query('id') required int commentId});
  @PUT(ApiEndpoints.updateComment)
  Future<void> updateComment(
      {@Body() required UpdateCommentInput updatecommentInput});
}

@JsonSerializable(createToJson: true)
class CommentInput {
  final int question_id;
  final int band_id;
  final String message;
  CommentInput({
    required this.band_id,
    required this.message,
    required this.question_id,
  });
  Map<String, dynamic> toJson() => _$CommentInputToJson(this);
}

@JsonSerializable(createToJson: true)
class GetCommentInQuestionInput {
  final int question_id;
  final int page;
  GetCommentInQuestionInput({
    required this.page,
    required this.question_id,
  });
  Map<String, dynamic> toJson() => _$GetCommentInQuestionInputToJson(this);
}

@JsonSerializable(createToJson: true)
class UpdateCommentInput {
  final int id;
  final String message;
  UpdateCommentInput({
    required this.message,
    required this.id,
  });
  Map<String, dynamic> toJson() => _$UpdateCommentInputToJson(this);
}
