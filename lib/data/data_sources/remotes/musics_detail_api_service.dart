import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'musics_detail_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class MusicsDetailApiService {
  @FactoryMethod()
  factory MusicsDetailApiService(Dio dio) = _MusicsDetailApiService;

  // all `SongDetail` request abstract here
}
