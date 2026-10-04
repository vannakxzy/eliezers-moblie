import 'package:injectable/injectable.dart';
import '../repository/category_repository.dart';

import '../../../../app/base/usecase/base_use_case.dart';

@Injectable()
class DeleteCategoryUsecase implements BaseUseCase<int, void> {
  DeleteCategoryUsecase(this._categoryRepostitory);
  final CategoryRepository _categoryRepostitory;
  @override
  Future<void> excecute(int input) async {
    return await _categoryRepostitory.deleteCategory(input);
  }
}
