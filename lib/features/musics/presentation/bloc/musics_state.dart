part of 'musics_bloc.dart';

@freezed
class MusicState extends BaseState with _$MusicState {
  const factory MusicState.initial({
    @Default(false) bool isloading,
    @Default(1) int page,
    @Default([]) List<MusicsEntity> musics,
    @Default(true) bool isMorePage,
    @Default(false) bool isShowSearch,
  }) = _Initial;
}
