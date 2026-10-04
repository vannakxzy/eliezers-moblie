import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/profile_repository.dart';

import '../entities/profile_entity.dart';

@Injectable()
class GetOtherProfileUseCase extends BaseUseCase<int, ProfileEntity> {
  final ProfileRepository _ProfileRepository;
  GetOtherProfileUseCase(this._ProfileRepository);
  @override
  Future<ProfileEntity> excecute(int input) async {
    return _ProfileRepository.getOtherProfile(userId: input);
  }
}
