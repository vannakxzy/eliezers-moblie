import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../question_detail/domain/entities/comment_respose_entity.dart';

import '../../../question_detail/domain/entities/comment_entity.dart';

abstract class CommentInQuestionRepository {
  Future<CommentResposeEntity> getCommentInQuesiton(int quesitonId, int page);
  Future<CommentEntity> createComment(CommentInput input);
  Future<void> likeComment({required int commnetId});
  Future<void> unLikeComment({required int commnetId});

  Future<void> deleteComment(int commentId);
  Future<void> updateComment(int commentId, String description);
}
