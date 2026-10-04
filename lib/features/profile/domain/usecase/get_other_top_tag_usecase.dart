import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../entities/top_tag_entity.dart';
import '../repository/profile_repository.dart';

@Injectable()
class GetOtherTopTagUseCase extends BaseUseCase<int, List<TopTagEntity>> {
  final ProfileRepository _ProfileRepository;
  GetOtherTopTagUseCase(this._ProfileRepository);
  @override
  Future<List<TopTagEntity>> excecute(int input) async {
    return await _ProfileRepository.getOtherTopTag(userId: input);
  }
}
