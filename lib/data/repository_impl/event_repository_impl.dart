import 'package:injectable/injectable.dart';

import '../../features/event/domain/entities/event_respose_entity.dart';
import '../../features/event/domain/repository/event_repository.dart';
import '../data_sources/remotes/event_api_service.dart';
import '../models/event/event_respose_model.dart';

@LazySingleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl(this._apiService);
  final EventApiService _apiService;
  @override
  Future<EventResposeEntity> getEvents(int page) async {
    final event = await _apiService.getEvents(page);
    return event.toEntity();
  }

  @override
  Future<void> booking(int eventId) async {
    await _apiService.booking(eventId);
  }

  @override
  Future<void> createEvent(CreateEventInput input) {
    return _apiService.createEvent(input: input);
  }
}
