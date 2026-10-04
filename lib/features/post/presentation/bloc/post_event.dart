part of 'post_bloc.dart';

class PostEvent extends BaseEvent {}

@freezed
class ClickCropEvent extends PostEvent with _$ClickCropEvent {
  factory ClickCropEvent() = _ClickCropEvent;
}

@freezed
class TitleChangedEvent extends PostEvent with _$TitleChangedEvent {
  factory TitleChangedEvent(String value) = _TitleChangedEvent;
}

@freezed
class DescriptionChangedEvent extends PostEvent with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String value) = _DescriptionChangedEvent;
}

@freezed
class TagChangedEvent extends PostEvent with _$TagChangedEvent {
  factory TagChangedEvent(String value) = _TagChangedEvent;
}

@freezed
class ClickSelectTagEvent extends PostEvent with _$ClickSelectTagEvent {
  factory ClickSelectTagEvent(TagEntity tags) = _ClickSelectTagEvent;
}

@freezed
class ClickRemoveTagEvent extends PostEvent with _$ClickRemoveTagEvent {
  factory ClickRemoveTagEvent(int index) = _ClickRemoveTagEvent;
}

@freezed
class PickImageCameraEvent extends PostEvent with _$PickImageCameraEvent {
  factory PickImageCameraEvent() = _PickImageCameraEvent;
}

@freezed
class PickImageGalleryEvent extends PostEvent with _$PickImageGalleryEvent {
  factory PickImageGalleryEvent() = _PickImageGalleryEvent;
}

@freezed
class ClickClearImageEvent extends PostEvent with _$ClickClearImageEvent {
  factory ClickClearImageEvent() = _ClickClearImageEvent;
}

@freezed
class ClickCreateTagEvent extends PostEvent with _$ClickCreateTagEvent {
  factory ClickCreateTagEvent(String value) = _ClickCreateTagEvent;
}

@freezed
class ClickPostQuestionEvent extends PostEvent with _$ClickPostQuestionEvent {
  factory ClickPostQuestionEvent(int bandId) = _ClickPostQuestionEvent;
}

@freezed
class ListenerFocusNodeEvent extends PostEvent with _$ListenerFocusNodeEvent {
  factory ListenerFocusNodeEvent(bool focus) = _ListenerFocusNodeEvent;
}

@freezed
class AuDientChanged extends PostEvent with _$AuDientChanged {
  factory AuDientChanged(String value) = _AuDientChanged;
}

@freezed
class InitPage extends PostEvent with _$InitPage {
  factory InitPage() = _InitPage;
}
