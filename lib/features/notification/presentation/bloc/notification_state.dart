part of 'notification_bloc.dart';

@freezed
class NotificationState extends BaseState with _$NotificationState {
  factory NotificationState({
    @Default(false) bool isLoading,
    @Default(false) bool readAll,
    @Default(1) int page,
    @Default(true) bool isMorePage,
    @Default([]) List<NotificationEntity> notification,
  }) = _Initial;
}
