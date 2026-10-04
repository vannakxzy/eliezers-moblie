import 'package:injectable/injectable.dart';
import '../entities/category_entity.dart';
import '../repository/category_repository.dart';

import '../../../../app/base/usecase/base_use_case.dart';

@Injectable()
class GetCategoryEventUsecase
    implements BaseUseCase<void, List<CategoryEntity>> {
  final CategoryRepository _categoryRepository;
  GetCategoryEventUsecase(this._categoryRepository);

  @override
  Future<List<CategoryEntity>> excecute([_]) async {
    return await _categoryRepository.GetCategoryEvent();
  }
}
