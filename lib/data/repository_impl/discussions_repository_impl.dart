import 'package:injectable/injectable.dart';

import '../../features/discussions/domain/repository/discussions_repository.dart';

@LazySingleton(as: DiscussionsRepository)
class DiscussionsRepositoryImpl implements DiscussionsRepository {}
