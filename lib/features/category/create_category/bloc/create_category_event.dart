part of 'create_category_bloc.dart';

class CreateCategoryEvent extends BaseEvent {}

@freezed
class BookNameChangedEvent extends CreateCategoryEvent
    with _$BookNameChangedEvent {
  factory BookNameChangedEvent(String value) = _BookNameChangedEvent;
}

@freezed
class ClickPickCoverEvent extends CreateCategoryEvent
    with _$ClickPickCoverEvent {
  factory ClickPickCoverEvent(File image) = _ClickPickCoverEvent;
}

@freezed
class ClickCreateEvent extends CreateCategoryEvent with _$ClickCreateEvent {
  factory ClickCreateEvent(int questionId, BuildContext context) = _ClcikCreate;
}

@freezed
class ClickClearCoverEvent extends CreateCategoryEvent
    with _$ClickClearCoverEvent {
  factory ClickClearCoverEvent() = _ClickClearCoverEvent;
}
