part of 'notification_bloc.dart';

abstract class NotificationEvent extends BaseEvent {}

@freezed
class GetNotification extends NotificationEvent with _$GetNotification {
  factory GetNotification() = _GetNotification;
}

@freezed
class ClickReport extends NotificationEvent with _$ClickReport {
  factory ClickReport() = _ClickReport;
}

@freezed
class ClickReadAll extends NotificationEvent with _$ClickReadAll {
  factory ClickReadAll() = _ClickReadAll;
}

@freezed
class ClickNotification extends NotificationEvent with _$ClickNotification {
  factory ClickNotification(int index) = _ClickNotification;
}

@freezed
class ClickDeleteNotificaiton extends NotificationEvent
    with _$ClickDeleteNotificaiton {
  factory ClickDeleteNotificaiton(int index) = _ClickDeleteNotificaiton;
}

@freezed
class ClickHideThisType extends NotificationEvent with _$ClickHideThisType {
  factory ClickHideThisType(String type) = _ClickHideThisType;
}

@freezed
class RefreshPage extends NotificationEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class ClickAvatar extends NotificationEvent with _$ClickAvatar {
  factory ClickAvatar(int userId) = _ClickAvatar;
}

@freezed
class ClickApproveUserInband extends NotificationEvent
    with _$ClickApproveUserInband {
  factory ClickApproveUserInband(int index) = _ClickApproveUserInband;
}

@freezed
class ClickRejectUserInband extends NotificationEvent
    with _$ClickRejectUserInband {
  factory ClickRejectUserInband(int index) = _ClickRejectUserInband;
}
