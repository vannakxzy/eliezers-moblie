part of 'feedback_bloc.dart';

class FeedbackEvent extends BaseEvent {}

@freezed
class DescriptionChangedEvent extends FeedbackEvent
    with _$DescriptionChangedEvent {
  factory DescriptionChangedEvent(String value) = _DescriptionChangedEvent;
}

@freezed
class ClickSubmitEvent extends FeedbackEvent with _$ClickSubmitEvent {
  factory ClickSubmitEvent() = _ClickSubmitEvent;
}
