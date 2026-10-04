part of 'splash_page_bloc.dart';

class SplashPageEvent extends BaseEvent {}

@freezed
class InitSplashPageEvent extends SplashPageEvent with _$InitSplashPageEvent {
  factory InitSplashPageEvent() = _InitSplashPageEvent;
}
