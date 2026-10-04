import 'package:injectable/injectable.dart';
import '../data_sources/remotes/comment_in_question_api_service.dart';
import '../models/question_detail/comment_model.dart';
import '../models/question_detail/comment_respose_model.dart';
import '../../features/question_detail/domain/entities/comment_entity.dart';

import '../../features/comment_in_question/domain/repository/comment_in_question_repository.dart';
import '../../features/question_detail/domain/entities/comment_respose_entity.dart';

@LazySingleton(as: CommentInQuestionRepository)
class CommentInQuestionRepositoryImpl implements CommentInQuestionRepository {
  final CommentInQuestionApiService _apiService;
  CommentInQuestionRepositoryImpl(this._apiService);
  @override
  Future<CommentEntity> createComment(CommentInput input) async {
    final data = await _apiService.createComment(commentInput: input);
    return data.toEntity();
  }

  @override
  Future<void> deleteComment(int commentId) async {
    return await _apiService.deleteComment(commentId: commentId);
  }

  @override
  Future<void> likeComment({required int commnetId}) async {
    return await _apiService.likeComment(commentId: commnetId);
  }

  @override
  Future<void> updateComment(int commentId, String description) async {
    return await _apiService.updateComment(
        updatecommentInput:
            UpdateCommentInput(message: description, id: commentId));
  }

  @override
  Future<CommentResposeEntity> getCommentInQuesiton(
      int quesitonId, int page) async {
    final comment = await _apiService.getCommentInQuestion(
        input: GetCommentInQuestionInput(page: page, question_id: quesitonId));
    return comment.toEntity();
  }

  @override
  Future<void> unLikeComment({required int commnetId}) async {
    return await _apiService.unLikeComment(commentId: commnetId);
  }
}
