import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/create_account_api_service.dart';
import '../entities/create_account_entity.dart';
import '../repository/create_account_repository.dart';

@Injectable()
class CreateAccountUsecase
    extends BaseUseCase<CreateAccountInput, CreateAccountEntity> {
  final CreateAccountRepository _accountRepository;
  CreateAccountUsecase(this._accountRepository);
  @override
  Future<CreateAccountEntity> excecute(CreateAccountInput input) async {
    return await _accountRepository.createAccount(createAccountInput: input);
  }
}
