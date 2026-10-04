import 'package:injectable/injectable.dart';
import '../data_sources/remotes/comment_in_answer_api_service.dart';
import '../models/question_detail/comment_model.dart';
import '../models/question_detail/comment_respose_model.dart';
import '../../features/question_detail/domain/entities/comment_entity.dart';
import '../../features/question_detail/domain/entities/comment_respose_entity.dart';

import '../../features/comment_in_answer/domain/repository/comment_in_answer_repository.dart';

@LazySingleton(as: CommentInAnswerRepository)
class CommentInAnswerRepositoryImpl implements CommentInAnswerRepository {
  final CommentInAnswerApiService _service;
  CommentInAnswerRepositoryImpl(this._service);

  @override
  Future<CommentEntity> createCommentInanswer(
      CreateCommnetInAnswer input) async {
    final comment = await _service.createCommentInAnswer(
      createCommnetInAnswer: input,
    );
    return comment.toEntity();
  }

  @override
  Future<CommentResposeEntity> getCommentInAnswer(
      int answweId, int page) async {
    final data = await _service.getCommentInAnswer(
        input: GetCommentAnswerInput(page: page, answer_id: answweId));
    return data.toEntity();
  }
}
