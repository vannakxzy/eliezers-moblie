import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/notification/notification_respose_model.dart';

part 'notification_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class NotificationApiService {
  @FactoryMethod()
  factory NotificationApiService(Dio dio) = _NotificationApiService;
  @GET(ApiEndpoints.notification)
  Future<NotificationResposeModel> getNotification(
      {@Query('page') required int id});
  @DELETE(ApiEndpoints.notification)
  Future<void> deleteNotification(@Body() NotificationInput input);

  @PUT("${ApiEndpoints.notification}/read")
  Future<void> readNotification(@Body() NotificationInput input);

  @PUT("${ApiEndpoints.notification}/read-all")
  Future<void> readAll();
}

@JsonSerializable(createToJson: true)
class NotificationInput {
  final String type;
  final int comment_id;
  final int answer_id;
  final int question_id;
  final int id;
  NotificationInput({
    required this.type,
    required this.comment_id,
    required this.answer_id,
    required this.question_id,
    required this.id,
  });
  Map<String, dynamic> toJson() => _$NotificationInputToJson(this);
}
