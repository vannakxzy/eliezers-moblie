import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/constants.dart';
import '../../models/event/event_respose_model.dart';

part 'event_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class EventApiService {
  @FactoryMethod()
  factory EventApiService(Dio dio) = _EventApiService;
  @GET(ApiEndpoints.events)
  Future<EventResposeModel> getEvents(@Query("page") int page);
  @POST(ApiEndpoints.join)
  Future<void> booking({@Body() required BookingInput input});
  @DELETE('${ApiEndpoints.deletejoinEvent}/{id}')
  Future<void> deleteBooking(@Path('id') int eventId);
  @DELETE('${ApiEndpoints.events}/{id}')
  Future<void> deleteEvent(@Path('id') int eventId);
  @PUT(ApiEndpoints.events)
  Future<void> putEvent({@Body() required CreateEventInput input});
  @POST(ApiEndpoints.events)
  Future<void> createEvent({@Body() required CreateEventInput input});
}
@JsonSerializable()
class BookingInput {
  final int eventId;
  BookingInput({required this.eventId});
  Map<String, dynamic> toJson() => {
        'event_id': eventId,
      };
}
@JsonSerializable(createToJson: true)
class CreateEventInput {
  final String title;
  final String description;
  final List<String>? cover;
  final String start_time;
  final String end_time;
  final double latitude;
  final double longitude;
  final List<int>? music_ids;
  CreateEventInput({
    required this.title,
    required this.description,
      required this.cover,
    required this.music_ids,
    required this.start_time,
    required this.end_time,
      required this.longitude,
      required this.latitude

  });
  Map<String, dynamic> toJson() => _$CreateEventInputToJson(this);
}
