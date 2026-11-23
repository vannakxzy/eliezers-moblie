import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/models/bible/bible_content_response_model.dart';
import '../repository/bible_repository.dart';

@Injectable()
class GetBibleBookUsecase extends BaseUseCase<void, BibleContentResponseModel> {
  final BibleRepository _BibleRepository;
  GetBibleBookUsecase(this._BibleRepository);

  @override
  Future<BibleContentResponseModel> excecute(void input) async {
    final rerkkk = await _BibleRepository.getBibleBook();
    return rerkkk;
    // throw UnimplementedError();
  }

  // @override
  // Future<BibleContentResponseModel> excecute(void input) async {
  //   return await _BibleRepository.getBibleBook();
  // }
}
