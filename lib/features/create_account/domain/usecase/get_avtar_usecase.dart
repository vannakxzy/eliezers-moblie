import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/create_account_repository.dart';

import '../entities/avatar_entity.dart';

@Injectable()
class GetAvatarUsecase extends BaseUseCase<void, List<AvartaEntity>> {
  final CreateAccountRepository _SelectAvatarRepository;
  GetAvatarUsecase(this._SelectAvatarRepository);
  @override
  Future<List<AvartaEntity>> excecute(input) async {
    final avatar = await _SelectAvatarRepository.getAvatar();
    return avatar.data;
  }
}
