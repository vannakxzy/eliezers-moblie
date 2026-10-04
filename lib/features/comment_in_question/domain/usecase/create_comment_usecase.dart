import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../repository/comment_in_question_repository.dart';

import '../../../question_detail/domain/entities/comment_entity.dart';

@Injectable()
class CreateCommentUseCase extends BaseUseCase<CommentInput, CommentEntity> {
  final CommentInQuestionRepository _commentInQuestionRepository;
  CreateCommentUseCase(this._commentInQuestionRepository);
  @override
  Future<CommentEntity> excecute(CommentInput input) async {
    return await _commentInQuestionRepository.createComment(input);
  }
}
