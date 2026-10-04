import 'package:injectable/injectable.dart';

import '../../features/users/domain/repository/users_repository.dart';

@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {}
