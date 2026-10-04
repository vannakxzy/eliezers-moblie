part of 'result_search_bloc.dart';

class ResultSearchEvent extends BaseEvent {}

@freezed
class ClickSearchEvent extends ResultSearchEvent with _$ClickSearchEvent {
  factory ClickSearchEvent(String text) = _ClickSearchEvent;
}

@freezed
class ApplyFilerEvent extends ResultSearchEvent with _$ApplyFilerEvent {
  factory ApplyFilerEvent(FilterEntity filter) = _ApplyFilerEvent;
}

@freezed
class TextSearchInputChanged extends ResultSearchEvent
    with _$TextSearchInputChanged {
  factory TextSearchInputChanged(String value) = _TextSearchInputChanged;
}

@freezed
class ClearTextSearch extends ResultSearchEvent with _$ClearTextSearch {
  factory ClearTextSearch() = _ClearTextSearch;
}

@freezed
class InitialEvent extends ResultSearchEvent with _$InitialEvent {
  factory InitialEvent(String text) = _InitialEvent;
}

@freezed
class ClickRemoveHistoryItem extends ResultSearchEvent
    with _$ClickRemoveHistoryItem {
  factory ClickRemoveHistoryItem(int index) = _ClickRemoveHistoryItem;
}

@freezed
class ClickClearAllHistory extends ResultSearchEvent
    with _$ClickClearAllHistory {
  factory ClickClearAllHistory() = _ClickClearAllHistory;
}
