import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/musics_api_service.dart';
import '../repository/musics_repository.dart';

@Injectable()
class UpdateMusiceUsecase extends BaseUseCase<CreateMusicInput, void> {
  final MusicsRepository _repositoty;
  UpdateMusiceUsecase(this._repositoty);
  @override
  Future<void> excecute(CreateMusicInput input) async {
    await _repositoty.updateMusic(input);
  }
}
