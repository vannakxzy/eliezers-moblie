import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/music_respose_entity.dart';
import '../repository/musics_repository.dart';

@Injectable()
class GetMusicssUsecase extends BaseUseCase<int, MusicsResposeEntity> {
  final MusicsRepository _MusicsRepository;
  GetMusicssUsecase(this._MusicsRepository);
  @override
  Future<MusicsResposeEntity> excecute(int input) async {
    return await _MusicsRepository.getMusic(input);
  }
}
