
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/bible/bible_content_response_model.dart';
import '../../models/bible/bible_passege_model.dart';

part 'bible_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class BibleApiService {
  @factoryMethod
  factory BibleApiService(@Named('bible') Dio dio) = _BibleApiService;

  @GET('${ApiEndpoints.bible}/books')
  Future<BibleContentResponseModel> getBibleBook();

  @GET('${ApiEndpoints.bible}/passages/{passage_id_path}?format=html')
  Future<BiblePassegeModel> getPassageBible(
    @Path('passage_id_path') String passageIdPath,
  );
}
