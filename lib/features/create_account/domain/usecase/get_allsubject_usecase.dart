import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/create_account_repository.dart';
import '../../../home/domain/entities/subject_entity.dart';

@Injectable()
class GetAllSubjectUseCase extends BaseUseCase<void, List<SubjectEntity>> {
  final CreateAccountRepository _accountRepository;
  GetAllSubjectUseCase(this._accountRepository);
  @override
  Future<List<SubjectEntity>> excecute(void input) async {
    final subject = await _accountRepository.getAllSubject();
    return subject;
  }
}
