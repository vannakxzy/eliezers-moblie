import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class HomeApiService{
  @FactoryMethod()
  factory HomeApiService(Dio dio) = _HomeApiService;

  // all `Home` request abstract here
}