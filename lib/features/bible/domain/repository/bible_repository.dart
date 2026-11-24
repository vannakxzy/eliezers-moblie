import '../../../../data/models/bible/bible_content_response_model.dart';
import '../../../../data/models/bible/bible_language_model.dart';
import '../../../../data/models/bible/bible_language_respone_model.dart';
import '../../../../data/models/bible/bible_passege_model.dart';
import '../usecase/get_passage_bible_usecase.dart';

abstract class BibleRepository {
  Future<BibleContentResponseModel> getBibleBook(int bibleIdPath);
  Future<BiblePassegeModel> getPassageBible(GetPassageBibleParams input);
  Future<BibleLanguageResponeModel> getBibleLanguage();
}