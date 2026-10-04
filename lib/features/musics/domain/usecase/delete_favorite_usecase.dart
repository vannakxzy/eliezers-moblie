import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/musics_repository.dart';

@Injectable()
class DeleteFavoriteUsecase extends BaseUseCase<int, void> {
  final MusicsRepository _MusicsRepository;
  DeleteFavoriteUsecase(this._MusicsRepository);
  @override
  Future<void> excecute(int input) async {
    return await _MusicsRepository.deleteFavorite(input);
  }
}
