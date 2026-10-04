part of 'data_tag_answer_bloc.dart';

abstract class DataTagAnswerEvent extends BaseEvent {}

@freezed
class ClickAnswer extends DataTagAnswerEvent with _$ClickAnswer {
  factory ClickAnswer(AnswertEntity answer) = _ClickAnswer;
}

@freezed
class GetAnswer extends DataTagAnswerEvent with _$GetAnswer {
  factory GetAnswer({
    required int index,
    required int userId,
    required int tagId,
  }) = _GetAnswer;
}

@freezed
class RefreshPage extends DataTagAnswerEvent with _$RefreshPage {
  factory RefreshPage({
    required int index,
    required int userId,
    required int tagId,
  }) = _RefreshPage;
}

@freezed
class InitPage extends DataTagAnswerEvent with _$InitPage {
  factory InitPage({
    required int tagLenght,
  }) = _InitPage;
}
