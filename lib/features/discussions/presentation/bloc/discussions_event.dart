part of 'discussions_bloc.dart';

class DiscussionsEvent extends BaseEvent {}

@freezed
class GetDiscussion extends DiscussionsEvent with _$GetDiscussion {
  factory GetDiscussion() = _GetDiscussion;
}

@freezed
class ClickFilterDate extends DiscussionsEvent with _$ClickFilterDate {
  factory ClickFilterDate() = _ClickFilterDate;
}

@freezed
class ClickNewest extends DiscussionsEvent with _$ClickNewest {
  factory ClickNewest() = _ClickNewest;
}

@freezed
class ClickLastest extends DiscussionsEvent with _$ClickLastest {
  factory ClickLastest() = _ClickLastest;
}

@freezed
class ClickHighestScore extends DiscussionsEvent with _$ClickHighestScore {
  factory ClickHighestScore() = _ClickHighestScore;
}

@freezed
class ClickDiscussion extends DiscussionsEvent with _$ClickDiscussion {
  factory ClickDiscussion(QuestionEntity discussion) = _ClickDiscussion;
}

@freezed
class RefreshPage extends DiscussionsEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class ClickLikeEvent extends DiscussionsEvent with _$ClickLikeEvent {
  factory ClickLikeEvent(int index) = _ClickLikeEvent;
}

@freezed
class ClickShare extends DiscussionsEvent with _$ClickShare {
  factory ClickShare(QuestionEntity discusstion) = _ClickShare;
}

@freezed
class ClickReport extends DiscussionsEvent with _$ClickReport {
  factory ClickReport() = _ClickReport;
}

@freezed
class ClickSaveDiscussion extends DiscussionsEvent with _$ClickSaveDiscussion {
  factory ClickSaveDiscussion(int index) = _ClickSaveDiscussion;
}

@freezed
class ClickUnSave extends DiscussionsEvent with _$ClickUnSave {
  factory ClickUnSave() = _ClickUnSave;
}

@freezed
class ClickHideEvent extends DiscussionsEvent with _$ClickHideEvent {
  factory ClickHideEvent(int index) = _ClickHideEvent;
}

@freezed
class ClickUnHideEvent extends DiscussionsEvent with _$ClickUnHideEvent {
  factory ClickUnHideEvent(int index) = _ClickUnHideEvent;
}

@freezed
class ApplyFilerEvent extends DiscussionsEvent with _$ApplyFilerEvent {
  factory ApplyFilerEvent(FilterEntity filter) = _ApplyFilerEvent;
}

@freezed
class ClickPostDiscussion extends DiscussionsEvent with _$ClickPostDiscussion {
  factory ClickPostDiscussion() = _ClickPostDiscussion;
}
