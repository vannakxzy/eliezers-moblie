import '../../../question_detail/domain/entities/comment_respose_entity.dart';

import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../../../question_detail/domain/entities/comment_entity.dart';

abstract class CommentInAnswerRepository {
  Future<CommentResposeEntity> getCommentInAnswer(int answweId, int page);
  Future<CommentEntity> createCommentInanswer(CreateCommnetInAnswer input);
}
