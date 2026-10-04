import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/setting_api_service.dart';
import '../repository/setting_repository.dart';

@Injectable()
class UpdateSettingUsecase extends BaseUseCase<UpdateSettingInput, void> {
  final SettingRepository _settingRepository;
  UpdateSettingUsecase(this._settingRepository);
  @override
  Future<void> excecute(UpdateSettingInput input) async {
    return await _settingRepository.updateSetting(input: input);
  }
}
