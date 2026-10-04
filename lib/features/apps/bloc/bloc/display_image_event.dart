part of 'display_image_bloc.dart';

class DisplayImageEvent extends BaseEvent {}

@freezed
class ClickDownloadImage extends DisplayImageEvent with _$ClickDownloadImage {
  factory ClickDownloadImage(String image) = _ClickDownloadImage;
}

@freezed
class ClickReportImage extends DisplayImageEvent with _$ClickReportImage {
  factory ClickReportImage(ReportInput report) = _ClickReportImage;
}
