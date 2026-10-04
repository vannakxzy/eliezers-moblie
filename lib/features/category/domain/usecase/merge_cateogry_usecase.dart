import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../repository/category_repository.dart';

import '../../../../app/base/usecase/base_use_case.dart';

@Injectable()
class MergeCategoryUseCase extends BaseUseCase<Mergeinput, void> {
  MergeCategoryUseCase(this._categoryRepository);
  final CategoryRepository _categoryRepository;
  @override
  Future excecute(input) async {
    return await _categoryRepository.merge(mergeinput: input);
  }
}
