part of 'band_detail_bloc.dart';

class BandDetailEvent extends BaseEvent {}

@freezed
class ClickSaveQuestion extends BandDetailEvent with _$ClickSaveQuestion {
  factory ClickSaveQuestion(int index) = _ClickSaveQuestion;
}

@freezed
class ApplyFilerEvent extends BandDetailEvent with _$ApplyFilerEvent {
  factory ApplyFilerEvent(FilterEntity filter) = _ApplyFilerEvent;
}

@freezed
class RefreshPage extends BandDetailEvent with _$RefreshPage {
  factory RefreshPage() = _OnRefreshPageEvent;
}

@freezed
class ClickOutsiteCreatePost extends BandDetailEvent
    with _$ClickOutsiteCreatePost {
  factory ClickOutsiteCreatePost() = _ClickOutsiteCreatePost;
}

@freezed
class ClickQuestionEvetn extends BandDetailEvent with _$ClickQuestionEvetn {
  factory ClickQuestionEvetn(QuestionEntity question, int id) =
      _ClickQuestionEvetn;
}

@freezed
class ClickPost extends BandDetailEvent with _$ClickPost {
  factory ClickPost() = _ClickPost;
}

@freezed
class DoubleTapEvent extends BandDetailEvent with _$DoubleTapEvent {
  factory DoubleTapEvent(int index) = _DoubleTapEvent;
}

@freezed
class ClickHideEvent extends BandDetailEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends BandDetailEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ClickCreateDiscussion extends BandDetailEvent
    with _$ClickCreateDiscussion {
  factory ClickCreateDiscussion(BandEntity band) = _ClickCreateDiscussion;
}

@freezed
class ClickLikeEvent extends BandDetailEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickOnUser extends BandDetailEvent with _$ClickOnUser {
  factory ClickOnUser(int id) = _ClickOnUser;
}

@freezed
class ClickShareQuestion extends BandDetailEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}

@freezed
class InitCommunitDetail extends BandDetailEvent with _$InitCommunitDetail {
  factory InitCommunitDetail(BandEntity band, int bandId) = _InitPage;
}

@freezed
class ListionScroll extends BandDetailEvent with _$ListionScroll {
  factory ListionScroll(double pi) = _ListionScroll;
}

@freezed
class ClickCreateQuestion extends BandDetailEvent with _$ClickCreateQuestion {
  factory ClickCreateQuestion(BandEntity band) = _ClickCreateQuestion;
}

@freezed
class ClickShare extends BandDetailEvent with _$ClickShare {
  factory ClickShare() = _ClickShare;
}

@freezed
class ClickEdit extends BandDetailEvent with _$ClickEdit {
  factory ClickEdit(int bandId) = _ClickEdit;
}

@freezed
class ClickReport extends BandDetailEvent with _$ClickReport {
  factory ClickReport() = _ClickReport;
}

@freezed
class ClickJoin extends BandDetailEvent with _$ClickJoin {
  factory ClickJoin(int bandId) = _ClickJoin;
}

@freezed
class ClickLeaveCommunit extends BandDetailEvent with _$ClickLeaveCommunit {
  factory ClickLeaveCommunit(int bandId) = _ClickLeave;
}

@freezed
class ClickRequest extends BandDetailEvent with _$ClickRequest {
  factory ClickRequest(int bandId) = _ClickRequest;
}

@freezed
class ClickCancelRequest extends BandDetailEvent with _$ClickCancelRequest {
  factory ClickCancelRequest(int bandId) = _ClickCancelRequest;
}

@freezed
class ClickSeebandInfo extends BandDetailEvent with _$ClickSeebandInfo {
  factory ClickSeebandInfo() = _ClickSeebandInfo;
}

@freezed
class ClickManageband extends BandDetailEvent with _$ClickManageband {
  factory ClickManageband(BandEntity band) = _ClickManageband;
}

@freezed
class ClickViembandinfo extends BandDetailEvent with _$ClickViembandinfo {
  factory ClickViembandinfo(BandEntity band) = _ClickViembandinfo;
}

@freezed
class ClickDeleteAndLeave extends BandDetailEvent with _$ClickDeleteAndLeave {
  factory ClickDeleteAndLeave(int bandId) = _ClickDeleteAndLeave;
}
