part of 'result_answer_bloc.dart';

class ResultAnswerEvent extends BaseEvent {}

@freezed
class SearchAnswerEvent extends ResultAnswerEvent with _$SearchAnswerEvent {
  factory SearchAnswerEvent(String q) = _SearchAnswerEvent;
}

@freezed
class RefreshPage extends ResultAnswerEvent with _$RefreshPage {
  factory RefreshPage(String q) = _RefreshPage;
}

@freezed
class ClickAnswer extends ResultAnswerEvent with _$ClickAnswer {
  factory ClickAnswer(AnswertEntity answer) = _ClickAnswer;
}

@freezed
class ClickAvatar extends ResultAnswerEvent with _$ClickAvatar {
  factory ClickAvatar(int userId) = _ClickAvatar;
}

@freezed
class RemoveIndex extends ResultAnswerEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultAnswerEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
