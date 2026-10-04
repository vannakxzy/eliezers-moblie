part of 'block_bloc.dart';

@freezed
class BlockState extends BaseState with _$BlockState {
  const factory BlockState({
    @Default([]) List<BlockEntity> blocks,
    @Default(false) bool isLoading,
    @Default(1) int page,
    @Default(true) bool isMorePage,
  }) = _BlockState;
}
