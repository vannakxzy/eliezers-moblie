import 'package:injectable/injectable.dart';

import '../../features/favorite/domain/repository/favorite_repository.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {}
