part of 'result_tag_bloc.dart';

@freezed
class ResultTagState extends BaseState with _$ResultTagState {
  const factory ResultTagState.initial({
    @Default(false) bool isloading,
    @Default([]) List<TagEntity> tags,
    @Default([]) List<TagEntity> recentSearch,
    @Default(1) int page,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
