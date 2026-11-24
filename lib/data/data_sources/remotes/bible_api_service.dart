import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/bible/bible_content_response_model.dart';
import '../../models/bible/bible_language_model.dart';
import '../../models/bible/bible_language_respone_model.dart';
import '../../models/bible/bible_passege_model.dart';

part 'bible_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class BibleApiService {
  @factoryMethod
  factory BibleApiService(@Named('bible') Dio dio) = _BibleApiService;

  // Get Bible books
  @GET('${ApiEndpoints.bible}/{bible_id_path}/books')
  Future<BibleContentResponseModel> getBibleBook({
    @Path('bible_id_path') required int bibleIdPath,
  });

  // Get Bible passage
  @GET(
    '${ApiEndpoints.bible}/{bible_id_path}/passages/{passage_id_path}?format=html',
  )
  Future<BiblePassegeModel> getPassageBible({
    @Path('bible_id_path') required int bibleIdPath,
    @Path('passage_id_path') required String passageIdPath,
  });

  @GET(ApiEndpoints.bibleLanguange)
  Future<BibleLanguageResponeModel> getBiblelanguage();
}
