import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'bible_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class BibleApiService{
  @FactoryMethod()
  factory BibleApiService(Dio dio) = _BibleApiService;

  // all `Bible` request abstract here
}