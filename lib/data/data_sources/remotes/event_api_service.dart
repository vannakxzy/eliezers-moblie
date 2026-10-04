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
  @POST(ApiEndpoints.booking)
  Future<void> booking(@Query("event_id") int eventId);
  @POST(ApiEndpoints.events)
  Future<void> createEvent({@Body() required CreateEventInput input});
}

@JsonSerializable(createToJson: true)
class CreateEventInput {
  final String title;
  final String description;
  final String? cover;
  final String location;
  final String start_time;
  final String end_time;
  final List<int>? music_ids;
  CreateEventInput({
    required this.title,
    required this.description,
    required this.cover,
    required this.location,
    required this.music_ids,
    required this.start_time,
    required this.end_time,
  });
  Map<String, dynamic> toJson() => _$CreateEventInputToJson(this);
}
