part of 'band_member_bloc.dart';

@freezed
class bandMemberState extends BaseState with _$bandMemberState {
  const factory bandMemberState.initial({
    @Default([]) List<bandMemberEntity> member,
    @Default([]) List<bandMemberEntity> newMember,

    // @Default([]) List<ProfileEntity> user,

    @Default(true) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default('') String textSearch,
    TextEditingController? textController,
  }) = _Initial;
}
