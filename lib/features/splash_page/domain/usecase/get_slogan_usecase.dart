import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/splash_page_repository.dart';

@Injectable()
class GetSloganUserCase extends BaseUseCase<void, String> {
  final SplashPageRepository _splashPageRepository;
  GetSloganUserCase(this._splashPageRepository);

  @override
  Future<String> excecute(void input) {
    return _splashPageRepository.getSlogan();
  }
}
