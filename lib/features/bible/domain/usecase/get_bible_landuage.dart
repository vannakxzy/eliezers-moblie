import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/models/bible/bible_language_respone_model.dart';
import '../repository/bible_repository.dart';

@Injectable()
class GetBibleLanduage extends BaseUseCase<void, BibleLanguageResponeModel> {
  final BibleRepository _BibleRepository;
  GetBibleLanduage(this._BibleRepository);

  @override
  Future<BibleLanguageResponeModel> excecute(void input) async {
    final respone = await _BibleRepository.getBibleLanguage();
    return respone;
  }
}
