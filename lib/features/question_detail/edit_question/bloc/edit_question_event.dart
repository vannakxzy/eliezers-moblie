part of 'edit_question_bloc.dart';

class EditQuestionEvent extends BaseEvent {}

@freezed
class TitleChangedEvent extends EditQuestionEvent with _$TitleChangedEvent {
  factory TitleChangedEvent(String value) = _TitleChangedEvent;
}

@freezed
class DescriptionChangedEvent extends EditQuestionEvent
    with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String value) = _DescriptionChangedEvent;
}

@freezed
class TagChangedEvent extends EditQuestionEvent with _$TagChangedEvent {
  factory TagChangedEvent(String value) = _TagChangedEvent;
}

@freezed
class ClickSelectTagEvent extends EditQuestionEvent with _$ClickSelectTagEvent {
  factory ClickSelectTagEvent(TagEntity tags) = _ClickSelectTagEvent;
}

@freezed
class ClickRemoveTagEvent extends EditQuestionEvent with _$ClickRemoveTagEvent {
  factory ClickRemoveTagEvent(int index) = _ClickRemoveTagEvent;
}

@freezed
class PickImageCameraEvent extends EditQuestionEvent
    with _$PickImageCameraEvent {
  factory PickImageCameraEvent() = _PickImageCameraEvent;
}

@freezed
class PickImageGalleryEvent extends EditQuestionEvent
    with _$PickImageGalleryEvent {
  factory PickImageGalleryEvent() = _PickImageGalleryEvent;
}

@freezed
class ClickClearImageEvent extends EditQuestionEvent
    with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickCreateTagEvent extends EditQuestionEvent with _$ClickCreateTagEvent {
  factory ClickCreateTagEvent(String value) = _ClickCreateTagEvent;
}

@freezed
class ClickUpdateQuestionEvent extends EditQuestionEvent
    with _$ClickUpdateQuestionEvent {
  factory ClickUpdateQuestionEvent() = _ClickUpdateQuestionEvent;
}

@freezed
class InitPageEvent extends EditQuestionEvent with _$InitPageEvent {
  factory InitPageEvent(QuestionEntity question) = _InitPageEvent;
}

@freezed
class ListenerFocusNodeEvent extends EditQuestionEvent
    with _$ListenerFocusNodeEvent {
  factory ListenerFocusNodeEvent(bool focus) = _ListenerFocusNodeEvent;
}

@freezed
class ClickCropEvent extends EditQuestionEvent with _$ClickCropEvent {
  factory ClickCropEvent() = _ClickCropEvent;
}

@freezed
class AuienceChanged extends EditQuestionEvent with _$AuienceChanged {
  factory AuienceChanged(String value) = _AuienceChanged;
}
