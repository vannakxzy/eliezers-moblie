import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/block_respnose_entity.dart';
import '../repository/security_login_repository.dart';

@Injectable()
class GetBlockUseCase extends BaseUseCase<int, BlockRespnoseEntity> {
  @override
  GetBlockUseCase(this._securityLoginRepository);
  final SecurityLoginRepository _securityLoginRepository;

  @override
  Future<BlockRespnoseEntity> excecute(int input) {
    return _securityLoginRepository.getBlock(input);
  }
}
