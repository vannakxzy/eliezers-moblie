import 'package:injectable/injectable.dart';

import '../../features/testhome/domain/repository/testhome_repository.dart';

@LazySingleton(as: TesthomeRepository)
class TesthomeRepositoryImpl implements TesthomeRepository {}
