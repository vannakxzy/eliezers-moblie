import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/home_api_service.dart';
import '../repository/home_repository.dart';

@Injectable()
class PostDeviceTokenUsecase extends BaseUseCase<PostDeviceTokenInput, void> {
  PostDeviceTokenUsecase(this._homeRepository);
  final HomeRepository _homeRepository;
  @override
  Future<void> excecute(input) async {
    return await _homeRepository.postDeviceToken(
        deviceToken: input.device_token);
  }
}
