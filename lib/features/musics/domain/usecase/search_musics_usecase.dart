import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../entities/music_respose_entity.dart';
import '../repository/musics_repository.dart';

@Injectable()
class SearchMusicsUsecase extends BaseUseCase<String, MusicsResposeEntity> {
  final MusicsRepository _MusicsRepository;
  SearchMusicsUsecase(this._MusicsRepository);
  @override
  Future<MusicsResposeEntity> excecute(String input) async {
    return await _MusicsRepository.searchMusics(input);
  }
}
