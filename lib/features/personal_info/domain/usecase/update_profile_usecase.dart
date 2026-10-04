import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/personal_info_repository.dart';

@Injectable()
class UpdateProfileUsecase extends BaseUseCase<String, void> {
  final PersonalInfoRepository _personalInfoRepository;
  UpdateProfileUsecase(this._personalInfoRepository);
  @override
  Future<void> excecute(String input) async {
    return await _personalInfoRepository.updateProfile(profile: input);
  }
}
