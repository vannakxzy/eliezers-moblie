part of 'report_bloc.dart';

class ReportEvent extends BaseEvent {}

@freezed
class InitPage extends ReportEvent with _$InitPage {
  factory InitPage(
      {required int commentId,
      required int answerId,
      required int questionId,
      required int userId}) = _InitPage;
}

@freezed
class GetReportTypeDetailEvent extends ReportEvent
    with _$GetReportTypeDetailEvent {
  factory GetReportTypeDetailEvent(int index) = _GetReportTypeDetailEvent;
}

@freezed
class MessageChangedEvent extends ReportEvent with _$MessageChangedEvent {
  factory MessageChangedEvent(String value) = _MessageChangedEvent;
}

@freezed
class ClickReportTypeEvent extends ReportEvent with _$ClickReportTypeEvent {
  factory ClickReportTypeEvent(int index) = _ClickReportTypeEvent;
}

@freezed
class ClickReportTypeDetailEvent extends ReportEvent
    with _$ClickReportTypeDetailEvent {
  factory ClickReportTypeDetailEvent(String name) = _ClickReportTypeDetailEvent;
}

@freezed
class PageChangeEvent extends ReportEvent with _$PageChangeEvent {
  factory PageChangeEvent(int index) = _PageChangeEvent;
}

@freezed
class ClickCreateReportEvent extends ReportEvent with _$ClickCreateReportEvent {
  factory ClickCreateReportEvent(int typeIndex) = _ClickCreateReportEvent;
}
