import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api_service.g.dart';


@LazySingleton()
@RestApi()
abstract class UsersApiService{
  @FactoryMethod()
  factory UsersApiService(Dio dio) = _UsersApiService;

  // all `Users` request abstract here
}