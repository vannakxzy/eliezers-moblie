import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../../../question_detail/domain/entities/comment_respose_entity.dart';

import '../repository/comment_in_answer_repository.dart';

@Injectable()
class GetCommentInAnswerUseCase
    extends BaseUseCase<GetCommentAnswerInput, CommentResposeEntity> {
  final CommentInAnswerRepository _commentInAnswerRepository;
  GetCommentInAnswerUseCase(this._commentInAnswerRepository);
  @override
  Future<CommentResposeEntity> excecute(input) async {
    return await _commentInAnswerRepository.getCommentInAnswer(
        input.answer_id, input.page);
  }
}
