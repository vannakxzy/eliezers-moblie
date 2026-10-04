import '../../../../data/data_sources/remotes/event_api_service.dart';
import '../entities/event_respose_entity.dart';

abstract class EventRepository {
  Future<EventResposeEntity> getEvents(int page);
  Future<void> booking(int eventId);
  Future<void> createEvent(CreateEventInput input);
}
