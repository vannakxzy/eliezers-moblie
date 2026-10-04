import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'discussions_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class DiscussionsApiService{
  @FactoryMethod()
  factory DiscussionsApiService(Dio dio) = _DiscussionsApiService;

  // all `Discussions` request abstract here
}