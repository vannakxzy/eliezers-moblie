import 'package:injectable/injectable.dart';
import '../../../../app/base/usecase/base_use_case.dart';

import '../../../../data/models/bible/bible_content_response_model.dart';
import '../../../../data/models/bible/bible_passege_model.dart';
import '../repository/bible_repository.dart';

@Injectable()
class GetPassageBibleUsecase
    extends BaseUseCase<GetPassageBibleParams, BiblePassegeModel> {
  final BibleRepository _BibleRepository;
  GetPassageBibleUsecase(this._BibleRepository);

  @override
  Future<BiblePassegeModel> excecute(GetPassageBibleParams input) async {
    final data = await _BibleRepository.getPassageBible(input);
    return data;
  }
}
class GetPassageBibleParams {
  final int bibleId;
  final String passageId;

  const GetPassageBibleParams({
    required this.bibleId,
    required this.passageId,
  });
}
