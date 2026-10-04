import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../question_detail/domain/entities/comment_respose_entity.dart';

import '../repository/comment_in_question_repository.dart';

@Injectable()
class GetCommnetInQuestionUserCase
    extends BaseUseCase<GetCommentInQuestionInput, CommentResposeEntity> {
  GetCommnetInQuestionUserCase(this._commentInQuestionRepository);
  final CommentInQuestionRepository _commentInQuestionRepository;
  @override
  Future<CommentResposeEntity> excecute(GetCommentInQuestionInput input) async {
    return await _commentInQuestionRepository.getCommentInQuesiton(
        input.question_id, input.page);
  }
}
