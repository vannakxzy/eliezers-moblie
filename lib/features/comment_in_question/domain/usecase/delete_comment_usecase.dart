import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/comment_in_question_repository.dart';

@Injectable()
class DeleteCommentUsecase extends BaseUseCase<int, void> {
  final CommentInQuestionRepository _commentInQuestionRepository;
  DeleteCommentUsecase(this._commentInQuestionRepository);
  @override
  Future<void> excecute(int input) async {
    return await _commentInQuestionRepository.deleteComment(input);
  }
}
