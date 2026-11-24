import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/models/bible/bible_content_response_model.dart';
import '../repository/bible_repository.dart';

@Injectable()
class GetBibleBookUsecase extends BaseUseCase<int, BibleContentResponseModel> {
  final BibleRepository _BibleRepository;
  GetBibleBookUsecase(this._BibleRepository);

  @override
  Future<BibleContentResponseModel> excecute(int input) async {
    final rerkkk = await _BibleRepository.getBibleBook(input);
    return rerkkk;
  }
}
