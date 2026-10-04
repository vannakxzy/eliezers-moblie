part of 'profile_bloc.dart';

abstract class ProfileEvent extends BaseEvent {}

@freezed
class InitPageEvent extends ProfileEvent with _$InitPageEvent {
  factory InitPageEvent(int userId) = _InitPageEvent;
}

@freezed
class GetProfileEvent extends ProfileEvent with _$GetProfileEvent {
  factory GetProfileEvent(int userId) = _GetProfileEvent;
}

@freezed
class GetQuestionEvent extends ProfileEvent with _$GetQuestionEvent {
  factory GetQuestionEvent(int userId) = _GetQuestionEvent;
}

@freezed
class GetAnswerEvent extends ProfileEvent with _$GetAnswerEvent {
  factory GetAnswerEvent(int userId) = _GetAnswerEvent;
}

@freezed
class GetTopTagEvent extends ProfileEvent with _$GetTopTagEvent {
  factory GetTopTagEvent(int userId) = _GetTopTagEvent;
}

@freezed
class GetSettingEvent extends ProfileEvent with _$GetSettingEvent {
  factory GetSettingEvent(int userId) = _GetSettingEvent;
}

@freezed
class RefreshPageEvent extends ProfileEvent with _$RefreshPageEvent {
  factory RefreshPageEvent(int userId) = _RefreshPageEvent;
}

@freezed
class ClickBlockEvent extends ProfileEvent with _$ClickBlockEvent {
  factory ClickBlockEvent(int userId) = _ClickBlockEvent;
}

@freezed
class ClickSendEvent extends ProfileEvent with _$ClickSendEvent {
  factory ClickSendEvent(int userId) = _ClickSendEvent;
}

@freezed
class ClickReportEvent extends ProfileEvent with _$ClickReportEvent {
  factory ClickReportEvent(int userId) = _ClickReportEvent;
}

@freezed
class ClickSettingEvent extends ProfileEvent with _$ClickSettingEvent {
  factory ClickSettingEvent() = _ClickSettingEvent;
}

@freezed
class ClickSeeAllQuestionEvent extends ProfileEvent
    with _$ClickSeeAllQuestionEvent {
  factory ClickSeeAllQuestionEvent(int userId) = _ClickSeeAllQuestionEvent;
}

@freezed
class ClickSeeAllAnswerEvent extends ProfileEvent
    with _$ClickSeeAllAnswerEvent {
  factory ClickSeeAllAnswerEvent(int userId) = _ClickSeeAllAnswerEvent;
}

@freezed
class ClickAnswerEvent extends ProfileEvent with _$ClickAnswerEvent {
  factory ClickAnswerEvent(AnswertEntity answer) = _ClickAnswerEvent;
}

@freezed
class ClickQuestionEvetn extends ProfileEvent with _$ClickQuestionEvetn {
  factory ClickQuestionEvetn(QuestionEntity question, int id) =
      _ClickQuestionEvetn;
}

@freezed
class DoubleTapEvent extends ProfileEvent with _$DoubleTapEvent {
  factory DoubleTapEvent(int index) = _DoubleTapEvent;
}

@freezed
class ClickHideEvent extends ProfileEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends ProfileEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ClickLikeEvent extends ProfileEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickShareUser extends ProfileEvent with _$ClickShareUser {
  factory ClickShareUser() = _ClickShareUser;
}
