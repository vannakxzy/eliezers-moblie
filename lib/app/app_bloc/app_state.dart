part of 'app_bloc.dart';

@freezed
class AppState extends BaseState with _$AppState {
  const factory AppState({Object? error}) = _Initial;
}
