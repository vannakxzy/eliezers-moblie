import 'package:injectable/injectable.dart';

import '../../features/bible/domain/repository/bible_repository.dart';

@LazySingleton(as: BibleRepository)
class BibleRepositoryImpl implements BibleRepository{
  
}