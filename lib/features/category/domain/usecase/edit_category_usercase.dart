import 'package:injectable/injectable.dart';
import '../repository/category_repository.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../entities/category_entity.dart';

@Injectable()
class EditCategoryUseCase
    extends BaseUseCase<EditCategoryInput, CategoryEntity> {
  EditCategoryUseCase(this._categoryRepository);

  final CategoryRepository _categoryRepository;
  @override
  Future<CategoryEntity> excecute(EditCategoryInput input) async {
    return await _categoryRepository.editCategory(input);
  }
}
