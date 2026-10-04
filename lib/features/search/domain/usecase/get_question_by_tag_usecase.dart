import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

import '../repository/search_repository.dart';

@Injectable()
class GetQuestionByTagUsecase
    extends BaseUseCase<GetQuestionByTagInput, QuestionResposeEntity> {
  final SearchRepository _repository;
  GetQuestionByTagUsecase(this._repository);

  @override
  Future<QuestionResposeEntity> excecute(GetQuestionByTagInput input) async {
    final question = await _repository.getQuestionByTag(input);
    return question;
  }
}
