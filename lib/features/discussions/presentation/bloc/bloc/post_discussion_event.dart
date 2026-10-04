part of 'post_discussion_bloc.dart';

class PostDiscussionEvent extends BaseEvent {}

@freezed
class ClickCropEvent extends PostDiscussionEvent with _$ClickCropEvent {
  factory ClickCropEvent() = _ClickCropEvent;
}

@freezed
class TitleChangedEvent extends PostDiscussionEvent with _$TitleChangedEvent {
  factory TitleChangedEvent(String value) = _TitleChangedEvent;
}

@freezed
class ClickPostDiscussionEvent extends PostDiscussionEvent
    with _$ClickPostDiscussionEvent {
  factory ClickPostDiscussionEvent() = _ClickPostDiscussionEvent;
}

@freezed
class DescriptionChangedEvent extends PostDiscussionEvent
    with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String value) = _DescriptionChangedEvent;
}

@freezed
class TagChangedEvent extends PostDiscussionEvent with _$TagChangedEvent {
  factory TagChangedEvent(String value) = _TagChangedEvent;
}

@freezed
class ClickSelectTagEvent extends PostDiscussionEvent
    with _$ClickSelectTagEvent {
  factory ClickSelectTagEvent(TagEntity tags) = _ClickSelectTagEvent;
}

@freezed
class ClickRemoveTagEvent extends PostDiscussionEvent
    with _$ClickRemoveTagEvent {
  factory ClickRemoveTagEvent(int index) = _ClickRemoveTagEvent;
}

@freezed
class PickImageCameraEvent extends PostDiscussionEvent
    with _$PickImageCameraEvent {
  factory PickImageCameraEvent() = _PickImageCameraEvent;
}

@freezed
class PickImageGalleryEvent extends PostDiscussionEvent
    with _$PickImageGalleryEvent {
  factory PickImageGalleryEvent() = _PickImageGalleryEvent;
}

@freezed
class ClickClearImageEvent extends PostDiscussionEvent
    with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickCreateTagEvent extends PostDiscussionEvent
    with _$ClickCreateTagEvent {
  factory ClickCreateTagEvent(String value) = _ClickCreateTagEvent;
}

@freezed
class ClickPostQuestionEvent extends PostDiscussionEvent
    with _$ClickPostQuestionEvent {
  factory ClickPostQuestionEvent(int bandId) = _ClickPostQuestionEvent;
}

@freezed
class ListenerFocusNodeEvent extends PostDiscussionEvent
    with _$ListenerFocusNodeEvent {
  factory ListenerFocusNodeEvent(bool focus) = _ListenerFocusNodeEvent;
}

@freezed
class AuDientChanged extends PostDiscussionEvent with _$AuDientChanged {
  factory AuDientChanged(String value) = _AuDientChanged;
}

@freezed
class InitPage extends PostDiscussionEvent with _$InitPage {
  factory InitPage() = _InitPage;
}
