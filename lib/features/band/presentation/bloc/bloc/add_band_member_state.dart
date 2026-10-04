part of 'add_band_member_bloc.dart';

@freezed
class AddbandMemberState extends BaseState with _$AddbandMemberState {
  const factory AddbandMemberState.initial({
    @Default([]) List<ProfileEntity> user,
    @Default([]) List<ProfileEntity> seletedUser,
    @Default([]) List<bandMemberEntity> newMember,
    @Default(false) bool isLoading,
    @Default(true) bool isMorePage,
    @Default('') String textSearch,
    TextEditingController? textController,
    @Default(1) int page,
  }) = _Initial;
}
