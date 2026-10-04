import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../entities/category_entity.dart';
import '../repository/category_repository.dart';

@Injectable()
class CreateCategoryUserCase implements BaseUseCase<CreateCategoryInput, void> {
  CreateCategoryUserCase(this._categoryRepository);
  final CategoryRepository _categoryRepository;
  @override
  Future<CategoryEntity> excecute(CreateCategoryInput input) async {
    return await _categoryRepository.createCategory(createCategoryInput: input);
  }
}
