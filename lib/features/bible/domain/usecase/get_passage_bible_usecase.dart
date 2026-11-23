import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/models/bible/bible_content_response_model.dart';
import '../../../../data/models/bible/bible_passege_model.dart';
import '../repository/bible_repository.dart';

@Injectable()
class GetPassageBibleUsecase extends BaseUseCase<String, BiblePassegeModel> {
  final BibleRepository _BibleRepository;
  GetPassageBibleUsecase(this._BibleRepository);

  @override
  Future<BiblePassegeModel> excecute(String input) async {
    final data = await _BibleRepository.getPassageBible(input);
    return data;
  }
}
