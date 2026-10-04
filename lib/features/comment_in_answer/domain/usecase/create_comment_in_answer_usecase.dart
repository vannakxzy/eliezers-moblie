import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../question_detail/domain/entities/comment_entity.dart';

import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../repository/comment_in_answer_repository.dart';

@Injectable()
class CreateCommentInAnswerUsecase
    extends BaseUseCase<CreateCommnetInAnswer, void> {
  final CommentInAnswerRepository _commentInAnswerRepository;
  CreateCommentInAnswerUsecase(this._commentInAnswerRepository);
  @override
  Future<CommentEntity> excecute(input) async {
    return await _commentInAnswerRepository.createCommentInanswer(input);
  }
}
