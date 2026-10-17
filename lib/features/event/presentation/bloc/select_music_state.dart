part of 'select_music_bloc.dart';

@freezed
class SelectMusicState extends BaseState with _$SelectMusicState {
  const factory SelectMusicState({
    @Default(false) bool isLoading,
    @Default([]) List<MusicsEntity> musics,
    @Default("") String keyy,
  }) = _Initial;
}     
