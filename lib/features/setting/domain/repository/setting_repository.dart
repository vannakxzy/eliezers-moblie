import '../../../../data/data_sources/remotes/setting_api_service.dart';
import '../entities/setting_entity.dart';

abstract class SettingRepository {
  Future<SettingEntity> getSetting();
  Future<void> updateSetting({required UpdateSettingInput input});
}
