import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'testhome_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class TesthomeApiService{
  @FactoryMethod()
  factory TesthomeApiService(Dio dio) = _TesthomeApiService;

  // all `Testhome` request abstract here
}