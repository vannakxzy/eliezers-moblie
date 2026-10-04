import 'package:injectable/injectable.dart';
import '../repository/profile_repository.dart';

import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/profile_entity.dart';

@Injectable()
class GetProfileUsecase implements BaseUseCase<void, ProfileEntity> {
  final ProfileRepository _profileRepository;
  GetProfileUsecase(this._profileRepository);
  @override
  Future<ProfileEntity> excecute(_) async {
    return await _profileRepository.getProfile();
  }
}
