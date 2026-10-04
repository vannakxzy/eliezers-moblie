part of 'edit_category_bloc.dart';

class EditCategoryEvent extends BaseEvent {}

@freezed
class BookNameChangedEvent extends EditCategoryEvent
    with _$BookNameChangedEvent {
  factory BookNameChangedEvent(String value) = _BookNameChangedEvent;
}

@freezed
class GetDefault extends EditCategoryEvent with _$GetDefault {
  factory GetDefault(CategoryEntity category) = _GetDefault;
}

@freezed
class ClickPickCoverEvent extends EditCategoryEvent with _$ClickPickCoverEvent {
  factory ClickPickCoverEvent() = _ClickPickCoverEvent;
}

@freezed
class ClickClearCoverEvent extends EditCategoryEvent
    with _$ClickClearCoverEvent {
  factory ClickClearCoverEvent() = _ClickClearCoverEvent;
}

@freezed
class ClickUpdate extends EditCategoryEvent with _$ClickUpdate {
  factory ClickUpdate(int id) = _ClickUpdate;
}
