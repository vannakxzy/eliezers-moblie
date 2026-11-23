import '../../../../data/models/bible/bible_content_response_model.dart';
import '../../../../data/models/bible/bible_passege_model.dart';

abstract class BibleRepository {
  Future<BibleContentResponseModel> getBibleBook();
  Future<BiblePassegeModel> getPassageBible(String passage_id);
}