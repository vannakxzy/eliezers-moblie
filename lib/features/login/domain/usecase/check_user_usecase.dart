import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../data/data_sources/remote/login_api_service.dart';
import '../repository/login_repository.dart';

@Injectable()
class CheckUserUsecase extends BaseUseCase<CheckUserInput, void> {
  final LoginRepository _repository;
  CheckUserUsecase(this._repository);

  @override
  Future<void> excecute(CheckUserInput input) async {
    return await _repository.checkUser(input);
  }
}
