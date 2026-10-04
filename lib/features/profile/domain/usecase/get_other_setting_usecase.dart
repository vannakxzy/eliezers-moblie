import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../setting/domain/entities/setting_entity.dart';

import '../repository/profile_repository.dart';

@Injectable()
class GetOtherSettingusecase extends BaseUseCase<int, SettingEntity> {
  final ProfileRepository _ProfileRepository;
  GetOtherSettingusecase(this._ProfileRepository);
  @override
  Future<SettingEntity> excecute(int input) async {
    return await _ProfileRepository.getOtherSetting(userId: input);
  }
}
