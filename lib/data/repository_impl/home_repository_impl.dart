import 'package:injectable/injectable.dart';

import '../../features/home/domain/repository/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository{
  
}