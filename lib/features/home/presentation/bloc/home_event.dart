part of 'home_bloc.dart';

abstract class HomeEvent extends BaseEvent {}

@freezed
class ClickNotification extends HomeEvent with _$ClickNotification {
  factory ClickNotification() = _ClickNotification;
}
