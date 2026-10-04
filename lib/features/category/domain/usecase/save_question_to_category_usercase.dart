import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../repository/category_repository.dart';

@Injectable()
class SaveQuestionToCategoryUserCase
    extends BaseUseCase<SaveQuestionInput, void> {
  final CategoryRepository _categoryRepository;
  SaveQuestionToCategoryUserCase(this._categoryRepository);

  @override
  Future excecute(input) async {
    return await _categoryRepository.saveQuestionToCategory(
        SaveQuestionInput: input);
  }
}
