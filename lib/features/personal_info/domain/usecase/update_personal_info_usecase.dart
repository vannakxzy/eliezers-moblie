import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/personal_info_api_service.dart';
import '../repository/personal_info_repository.dart';
import '../../../profile/domain/entities/profile_entity.dart';

@Injectable()
class UpdatePersonalInfoUsecase
    extends BaseUseCase<UpdatePersonalInfoInput, ProfileEntity> {
  final PersonalInfoRepository _personalInfoRepository;
  UpdatePersonalInfoUsecase(this._personalInfoRepository);
  @override
  Future<ProfileEntity> excecute(UpdatePersonalInfoInput input) async {
    return await _personalInfoRepository.updatePersonalInfo(
        updatePersonalInfoInput: input);
  }
}
