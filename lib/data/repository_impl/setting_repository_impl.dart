import 'package:injectable/injectable.dart';
import '../data_sources/remotes/setting_api_service.dart';
import '../models/create-account/settings/setting_model.dart';
import '../../features/setting/domain/entities/setting_entity.dart';

import '../../features/setting/domain/repository/setting_repository.dart';

@LazySingleton(as: SettingRepository)
class SettingImpl implements SettingRepository {
  final SettingApiService _apiService;
  SettingImpl(this._apiService);
  @override
  Future<SettingEntity> getSetting() async {
    final data = await _apiService.getSetting();
    return data.toEntity();
  }

  @override
  Future<void> updateSetting({required UpdateSettingInput input}) async {
    return await _apiService.updateSetting(input);
  }
}
