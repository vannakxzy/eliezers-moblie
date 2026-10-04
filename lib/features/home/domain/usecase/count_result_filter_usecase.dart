import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/home_repository.dart';

import '../../../../data/data_sources/remotes/home_api_service.dart';

@Injectable()
class CountResultFilterUsecase extends BaseUseCase<GetQuestionInput, int> {
  CountResultFilterUsecase(this._homeRepository);
  final HomeRepository _homeRepository;
  @override
  Future<int> excecute(GetQuestionInput input) async {
    return await _homeRepository.countResult(input);
  }
}
