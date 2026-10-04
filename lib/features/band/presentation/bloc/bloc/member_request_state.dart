part of 'member_request_bloc.dart';

@freezed
class MemberRequestState extends BaseState with _$MemberRequestState {
  const factory MemberRequestState.initial({
    @Default([]) List<bandMemberEntity> bandMember,
    @Default(true) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default('') String status,
  }) = _Initial;
}
