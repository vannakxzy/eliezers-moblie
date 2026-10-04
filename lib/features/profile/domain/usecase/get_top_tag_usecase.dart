import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../repository/profile_repository.dart';

@Injectable()
class GetTopTagUseCase extends BaseUseCase {
  final ProfileRepository _profileRepository;
  GetTopTagUseCase(this._profileRepository);
  @override
  Future excecute(input) async {
    return await _profileRepository.getTopTag();
  }
}
