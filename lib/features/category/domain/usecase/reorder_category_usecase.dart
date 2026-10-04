import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../repository/category_repository.dart';

@Injectable()
class ReorderCategoryUsecase
    implements BaseUseCase<ReOrderCategoryInput, void> {
  final CategoryRepository _categoryRepository;
  ReorderCategoryUsecase(this._categoryRepository);

  @override
  Future<void> excecute(input) async {
    return await _categoryRepository.reorderCategory(input: input);
  }
}
