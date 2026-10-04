part of 'band_info_bloc.dart';

@freezed
class bandInfoState extends BaseState with _$bandInfoState {
  const factory bandInfoState.initial({
    @Default([]) List<bandMemberEntity> member,
    @Default(false) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default(BandEntity()) BandEntity band,
  }) = _Initial;
}
