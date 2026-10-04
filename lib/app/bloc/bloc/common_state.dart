part of 'common_bloc.dart';

@freezed
class CommonState extends BaseState with _$CommonState {
  const factory CommonState({
    Exception? exception,
  }) = _CommonState;
}
