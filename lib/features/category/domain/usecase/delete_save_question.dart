import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/category_repository.dart';

@Injectable()
class DeleteSaveQuestionUseCase extends BaseUseCase<int, void> {
  final CategoryRepository _categoryRepository;
  DeleteSaveQuestionUseCase(this._categoryRepository);
  @override
  Future<void> excecute(int input) async {
    return await _categoryRepository.deleteQuestionInCateogry(input);
  }
}
