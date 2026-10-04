import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/personal_info_repository.dart';

@Injectable()
class CheckUserNameUseCase extends BaseUseCase<String, int> {
  final PersonalInfoRepository _personalInfoRepository;
  CheckUserNameUseCase(this._personalInfoRepository);
  @override
  Future<int> excecute(String input) async {
    return await _personalInfoRepository.checkUserName(userName: input);
  }
}
