import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../repository/category_repository.dart';
import '../../../home/domain/entities/question_respose_entity.dart';

@Injectable()
class GetQuestioninCategoryEventUseCase
    extends BaseUseCase<IdPageInput, QuestionResposeEntity> {
  final CategoryRepository _categoryRepository;
  GetQuestioninCategoryEventUseCase(this._categoryRepository);
  @override
  Future<QuestionResposeEntity> excecute(IdPageInput input) async {
    return await _categoryRepository.getQuestion(input: input);
  }
}
