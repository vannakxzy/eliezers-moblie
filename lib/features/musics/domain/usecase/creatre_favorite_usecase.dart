import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/musics_repository.dart';

@Injectable()
class CreatreFavoriteUsecase extends BaseUseCase<int, void> {
  final MusicsRepository _MusicsRepository;
  CreatreFavoriteUsecase(this._MusicsRepository);
  @override
  Future<void> excecute(int input) async {
    return await _MusicsRepository.createFavorite(input);
  }
}
