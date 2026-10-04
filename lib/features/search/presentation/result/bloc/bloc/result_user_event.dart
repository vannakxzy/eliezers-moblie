part of 'result_user_bloc.dart';

class ResultUserEvent extends BaseEvent {}

@freezed
class SearchUserEvent extends ResultUserEvent with _$SearchUserEvent {
  factory SearchUserEvent(String q) = _SearchUserEvent;
}

@freezed
class RefreshPage extends ResultUserEvent with _$RefreshPage {
  factory RefreshPage(String q) = _RefreshPage;
}

@freezed
class ClickUser extends ResultUserEvent with _$ClickUser {
  factory ClickUser(ProfileEntity user) = _ClickUser;
}

@freezed
class RemoveIndex extends ResultUserEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultUserEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
