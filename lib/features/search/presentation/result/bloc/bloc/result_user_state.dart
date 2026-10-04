part of 'result_user_bloc.dart';

@freezed
class ResultUserState extends BaseState with _$ResultUserState {
  const factory ResultUserState.initial({
    @Default(false) bool isloading,
    @Default([]) List<ProfileEntity> profile,
    @Default([]) List<ProfileEntity> recentSearch,
    @Default(1) int page,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
