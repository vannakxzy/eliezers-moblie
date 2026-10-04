import 'package:injectable/injectable.dart';

import '../../features/walkthrough/domain/repository/walkthrough_repository.dart';

@LazySingleton(as: WalkthroughRepository)
class WalkthroughRepositoryImpl implements WalkthroughRepository{
}