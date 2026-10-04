part of 'edit_discussion_bloc.dart';

class EditDiscussionEvent extends BaseEvent {}

@freezed
class TitleChangedEvent extends EditDiscussionEvent with _$TitleChangedEvent {
  factory TitleChangedEvent(String value) = _TitleChangedEvent;
}

@freezed
class DescriptionChangedEvent extends EditDiscussionEvent
    with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String value) = _DescriptionChangedEvent;
}

@freezed
class TagChangedEvent extends EditDiscussionEvent with _$TagChangedEvent {
  factory TagChangedEvent(String value) = _TagChangedEvent;
}

@freezed
class ClickSelectTagEvent extends EditDiscussionEvent
    with _$ClickSelectTagEvent {
  factory ClickSelectTagEvent(TagEntity tags) = _ClickSelectTagEvent;
}

@freezed
class ClickRemoveTagEvent extends EditDiscussionEvent
    with _$ClickRemoveTagEvent {
  factory ClickRemoveTagEvent(int index) = _ClickRemoveTagEvent;
}

@freezed
class PickImageCameraEvent extends EditDiscussionEvent
    with _$PickImageCameraEvent {
  factory PickImageCameraEvent() = _PickImageCameraEvent;
}

@freezed
class PickImageGalleryEvent extends EditDiscussionEvent
    with _$PickImageGalleryEvent {
  factory PickImageGalleryEvent() = _PickImageGalleryEvent;
}

@freezed
class ClickClearImageEvent extends EditDiscussionEvent
    with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickCreateTagEvent extends EditDiscussionEvent
    with _$ClickCreateTagEvent {
  factory ClickCreateTagEvent(String value) = _ClickCreateTagEvent;
}

@freezed
class ClickUpdateQuestionEvent extends EditDiscussionEvent
    with _$ClickUpdateQuestionEvent {
  factory ClickUpdateQuestionEvent() = _ClickUpdateQuestionEvent;
}

@freezed
class InitPageEvent extends EditDiscussionEvent with _$InitPageEvent {
  factory InitPageEvent(QuestionEntity question) = _InitPageEvent;
}

@freezed
class ListenerFocusNodeEvent extends EditDiscussionEvent
    with _$ListenerFocusNodeEvent {
  factory ListenerFocusNodeEvent(bool focus) = _ListenerFocusNodeEvent;
}

@freezed
class ClickCropEvent extends EditDiscussionEvent with _$ClickCropEvent {
  factory ClickCropEvent() = _ClickCropEvent;
}

@freezed
class AuienceChanged extends EditDiscussionEvent with _$AuienceChanged {
  factory AuienceChanged(String value) = _AuienceChanged;
}
