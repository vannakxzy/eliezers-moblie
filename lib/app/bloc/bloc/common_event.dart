part of 'common_bloc.dart';

@freezed
class CommonEvent extends BaseEvent with _$CommonEvent {
  const factory CommonEvent.addException(Exception exception) = _AddException;
}
