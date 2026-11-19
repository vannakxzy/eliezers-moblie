import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';
import '../repository/musics_repository.dart';

@Injectable()
class DeleteMusiceUsecase extends BaseUseCase<int, void> {
  final MusicsRepository _repositoty;
  DeleteMusiceUsecase(this._repositoty);
  @override
  Future<void> excecute(int input) async {
    await _repositoty.deleteMusic(input);
  }
}
