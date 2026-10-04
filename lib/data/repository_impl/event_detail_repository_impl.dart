import 'package:injectable/injectable.dart';

import '../../features/event_detail/domain/repository/event_detail_repository.dart';

@LazySingleton(as: EventDetailRepository)
class EventDetailRepositoryImpl implements EventDetailRepository {}
