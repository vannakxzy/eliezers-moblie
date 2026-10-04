import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/setting_entity.dart';
import '../repository/setting_repository.dart';

@Injectable()
class GetSettingUserCase extends BaseUseCase<void, SettingEntity> {
  final SettingRepository _settingRepository;
  GetSettingUserCase(this._settingRepository);
  @override
  Future<SettingEntity> excecute([input]) async {
    return await _settingRepository.getSetting();
  }
}
