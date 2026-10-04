import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'walkthrough_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class WalkthroughApiService{
  @FactoryMethod()
  factory WalkthroughApiService(Dio dio) = _WalkthroughApiService;

  // all `Walkthrough` request abstract here
}