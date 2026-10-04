import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'event_detail_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class EventDetailApiService{
  @FactoryMethod()
  factory EventDetailApiService(Dio dio) = _EventDetailApiService;

  // all `EventDetail` request abstract here
}