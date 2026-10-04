import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/create_account_repository.dart';

@Injectable()
class UpdateUserSubjectUsecase extends BaseUseCase<List<int>, void> {
  final CreateAccountRepository _accountRepository;
  UpdateUserSubjectUsecase(this._accountRepository);
  @override
  Future<void> excecute(List<int> input) async {
    await _accountRepository.updateUserSubject(subject: input);
  }
}
