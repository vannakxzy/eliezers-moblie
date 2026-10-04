part of 'search_bloc.dart';

abstract class SearchEvent extends BaseEvent {}

@freezed
class InitialEvent extends SearchEvent with _$InitialEvent {
  const factory InitialEvent() = _InitialEvent;
}

@freezed
class ClickSearchEvent extends SearchEvent with _$ClickSearchEvent {
  const factory ClickSearchEvent() = _ClickSearchEvent;
}

@freezed
class TextSearchInputChanged extends SearchEvent with _$TextSearchInputChanged {
  const factory TextSearchInputChanged({
    required String? textSearch,
  }) = _TextSearchInputChanged;
}

@freezed
class ClickHistoryItem extends SearchEvent with _$ClickHistoryItem {
  const factory ClickHistoryItem({
    required String text,
  }) = _ClickHistoryItem;
}

@freezed
class ClickRemoveHistoryItem extends SearchEvent with _$ClickRemoveHistoryItem {
  const factory ClickRemoveHistoryItem({
    required int index,
  }) = _ClickRemoveHistoryItem;
}

@freezed
class ClickMostSearchItem extends SearchEvent with _$ClickMostSearchItem {
  const factory ClickMostSearchItem({
    required String text,
  }) = _ClickMostSearchItem;
}

@freezed
class ClearTextSearchInput extends SearchEvent with _$ClearTextSearchInput {
  const factory ClearTextSearchInput() = _ClearTextSearchInput;
}

@freezed
class ClickShowMoreOrLess extends SearchEvent with _$ClickShowMoreOrLess {
  const factory ClickShowMoreOrLess() = _ClickShowMoreOrLess;
}

@freezed
class GetPopulaSearchEvent extends SearchEvent with _$GetPopulaSearchEvent {
  factory GetPopulaSearchEvent() = _GetPopulaSearchEvent;
}
