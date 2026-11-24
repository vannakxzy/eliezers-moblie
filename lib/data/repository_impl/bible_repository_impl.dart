import 'package:injectable/injectable.dart';

import '../../features/bible/domain/repository/bible_repository.dart';
import '../../features/bible/domain/usecase/get_passage_bible_usecase.dart';
import '../data_sources/remotes/bible_api_service.dart';
import '../models/bible/bible_content_response_model.dart';
import '../models/bible/bible_language_model.dart';
import '../models/bible/bible_language_respone_model.dart';
import '../models/bible/bible_passege_model.dart';

@LazySingleton(as: BibleRepository)
class BibleRepositoryImpl implements BibleRepository{
  BibleRepositoryImpl(this._apiService);

  final BibleApiService _apiService;

  @override
  Future<BibleContentResponseModel> getBibleBook(int bibleIdPath) async {
    final respone = await _apiService.getBibleBook(bibleIdPath: bibleIdPath);
    return respone;
  }

  @override
  Future<BiblePassegeModel> getPassageBible(GetPassageBibleParams input) async {
    final respone = await _apiService.getPassageBible(
        bibleIdPath: input.bibleId, passageIdPath: input.passageId);

    return respone;
  }

  @override
  Future<BibleLanguageResponeModel> getBibleLanguage() async {
    final respone = await _apiService.getBiblelanguage();
    return respone;
  }
 
  
}