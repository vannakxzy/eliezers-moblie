import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/report/report_type_detail_model.dart';
import '../../models/report/report_type_model.dart';

part 'report_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class ReportApiService {
  @FactoryMethod()
  factory ReportApiService(Dio dio) = _ReportApiService;
  @GET(ApiEndpoints.getReportType)
  Future<List<ReportTypeModel>> getReportType();
  @GET("${ApiEndpoints.getReportTypeDetail}/{id}")
  Future<List<ReportTypeDetailModel>> getReportTypeDetail(@Path('id') int id);
  @POST(ApiEndpoints.createReport)
  Future<void> createReport({@Body() required ReportInput reportInput});
}

@JsonSerializable(createToJson: true)
class ReportInput {
  final String reason;
  final int question_id;
  final int answer_id;
  final int comment_id;
  final int type_key;
  final int user_id;

  ReportInput({
    this.reason = '',
    this.question_id = 0,
    this.answer_id = 0,
    this.comment_id = 0,
    this.type_key = 0,
    this.user_id = 0,
  });

  Map<String, dynamic> toJson() => _$ReportInputToJson(this);

  // Add the copyWith method
  ReportInput copyWith(
      {String? reason,
      int? question_id,
      int? answer_id,
      int? comment_id,
      int? type_key,
      int? user_id}) {
    return ReportInput(
        reason: reason ?? this.reason,
        question_id: question_id ?? this.question_id,
        answer_id: answer_id ?? this.answer_id,
        comment_id: comment_id ?? this.comment_id,
        type_key: type_key ?? this.type_key,
        user_id: user_id ?? this.user_id);
  }
}
