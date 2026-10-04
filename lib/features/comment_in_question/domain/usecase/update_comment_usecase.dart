import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';

import '../repository/comment_in_question_repository.dart';

@Injectable()
class UpdateCommentUsecase extends BaseUseCase<CommentInput, void> {
  final CommentInQuestionRepository _commentInQuestionRepository;
  UpdateCommentUsecase(this._commentInQuestionRepository);
  @override
  Future<void> excecute(CommentInput input) async {
    return await _commentInQuestionRepository.updateComment(
        input.question_id, input.message);
  }
}
