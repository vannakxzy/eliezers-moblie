part of 'app_bloc.dart';

abstract class AppEvent extends BaseEvent {}

@freezed
class AppInitstate extends AppEvent with _$AppInitstate {
  const factory AppInitstate() = _AppInitstate;
}

@freezed
class CacheAppError extends AppEvent with _$CacheAppError {
  const factory CacheAppError(Object error) = _CacheAppError;
}
