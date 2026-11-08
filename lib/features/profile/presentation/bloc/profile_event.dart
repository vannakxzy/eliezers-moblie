part of 'profile_bloc.dart';

abstract class ProfileEvent extends BaseEvent {}

@freezed
class InitPageEvent extends ProfileEvent with _$InitPageEvent {
  factory InitPageEvent(int userId) = _InitPageEvent;
}

@freezed
class GetProfileEvent extends ProfileEvent with _$GetProfileEvent {
  factory GetProfileEvent(int userId) = _GetProfileEvent;
}
