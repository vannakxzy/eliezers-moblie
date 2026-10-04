part of 'all_answer_bloc.dart';

abstract class AllAnswerEvent extends BaseEvent {}

@freezed
class GetAnswerEvent extends AllAnswerEvent with _$GetAnswerEvent {
  factory GetAnswerEvent(int userId) = _GetAnswerEvent;
}

@freezed
class RefreshPage extends AllAnswerEvent with _$RefreshPage {
  factory RefreshPage(int userId) = _RefreshPage;
}

@freezed
class ClickAnswerEvent extends AllAnswerEvent with _$ClickAnswerEvent {
  factory ClickAnswerEvent(int questionId) = _ClickAnswerEvent;
}
