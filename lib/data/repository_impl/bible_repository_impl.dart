import 'package:injectable/injectable.dart';

import '../../features/bible/domain/repository/bible_repository.dart';
import '../data_sources/remotes/bible_api_service.dart';
import '../models/bible/bible_content_response_model.dart';
import '../models/bible/bible_passege_model.dart';

@LazySingleton(as: BibleRepository)
class BibleRepositoryImpl implements BibleRepository{
  BibleRepositoryImpl(this._apiService);

  final BibleApiService _apiService;
  @override
  Future<BibleContentResponseModel> getBibleBook() async {
    final resonse = await _apiService.getBibleBook();
    return resonse;
  }

  @override
  Future<BiblePassegeModel> getPassageBible(String passage_id) async {
    final reson = await _apiService.getPassageBible(passage_id);
    return reson;
  }
  
}