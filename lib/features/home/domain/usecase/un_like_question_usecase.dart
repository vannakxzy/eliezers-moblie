import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/home_repository.dart';

@Injectable()
class UnLikeQuestion extends BaseUseCase<int, void> {
  UnLikeQuestion(this._homeRepository);
  final HomeRepository _homeRepository;
  @override
  Future<void> excecute(input) async {
    return await _homeRepository.unLikeQuestion(input);
  }
}
