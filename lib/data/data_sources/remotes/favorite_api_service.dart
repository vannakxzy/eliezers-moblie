import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'favorite_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class FavoriteApiService{
  @FactoryMethod()
  factory FavoriteApiService(Dio dio) = _FavoriteApiService;

  // all `Favorite` request abstract here
}