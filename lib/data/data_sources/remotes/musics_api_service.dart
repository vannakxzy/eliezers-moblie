import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/musics/musics_respose_model.dart';

part 'musics_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class MusicsApiServie {
  @FactoryMethod()
  factory MusicsApiServie(Dio dio) = _MusicsApiServie;

  @GET(ApiEndpoints.musics)
  Future<MusicsResposeModel> getMusics(@Query("page") int page);

  @POST("${ApiEndpoints.favoriteMusics}/{id}")
  Future<void> createFavorites(@Path("id") int id);

  @DELETE("${ApiEndpoints.favoriteMusics}/{id}")
  Future<void> deletefavorite(@Path("id") int id);
}
