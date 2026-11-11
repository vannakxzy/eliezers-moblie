import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../../../../data/data_sources/remotes/musics_api_service.dart';
import '../repository/musics_repository.dart';

@Injectable()
class CreateMusicUsecase extends BaseUseCase<CreateMusicInput, void> {
  final MusicsRepository _repositoty;
  CreateMusicUsecase(this._repositoty);
  @override
  Future<void> excecute(CreateMusicInput input) async {
    // debugPrint("resposopory runningggggggg");
    await _repositoty.createMusic(input);

  }
}
