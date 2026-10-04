part of 'report_bloc.dart';

@freezed
class ReportState extends BaseState with _$ReportState {
  const factory ReportState({
    @Default(false) bool getloadinReport,
    @Default([]) List<bool> getloadingReportDetail,
    @Default([]) List<ReportTypeEntity> reportType,
    @Default([]) List<List<ReportTypeDetailEntity>> reportTypeDetail,
    @Default([]) List<String> selectedReportDetail,
    @Default('') String message,
    @Default(0) int page,
    @Default(0) int commendId,
    @Default(0) int questionId,
    @Default(0) int answerId,
    @Default(0) int userId,
    @Default(-1) int selectIndex,
  }) = _Initial;
}
