import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/home_repository.dart';

import '../entities/subject_entity.dart';

@Injectable()
class GetSubjectEventUseCase extends BaseUseCase<void, List<SubjectEntity>> {
  final HomeRepository _homeRepository;
  GetSubjectEventUseCase(this._homeRepository);
  @override
  Future<List<SubjectEntity>> excecute(input) async {
    return await _homeRepository.GetSubjectEvent();
  }
}
