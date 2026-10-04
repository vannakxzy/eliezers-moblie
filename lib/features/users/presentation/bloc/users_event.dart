
part of 'users_bloc.dart';

@freezed
class UsersEvent extends BaseEvent with _$UsersEvent {
  const factory UsersEvent.started() = _Started;
}