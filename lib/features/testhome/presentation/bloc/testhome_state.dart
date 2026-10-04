part of 'testhome_bloc.dart';

@freezed
class TesthomeState extends BaseState with _$TesthomeState {
  const factory TesthomeState.initial({
    @Default(0) x,
  }) = _Initial;
}
