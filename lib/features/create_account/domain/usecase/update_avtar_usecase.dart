import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/create_account_repository.dart';

@Injectable()
class UpdateAvtarUsecase implements BaseUseCase<String, void> {
  final CreateAccountRepository _accountRepository;
  UpdateAvtarUsecase(this._accountRepository);
  @override
  Future<void> excecute(String input) async {
    return await _accountRepository.updateAvatar(input);
  }
}
