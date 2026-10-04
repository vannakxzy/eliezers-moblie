part of 'search_band_bloc.dart';

class SearchbandEvent extends BaseEvent {}

@freezed
class InitialEvent extends SearchbandEvent with _$InitialEvent {
  const factory InitialEvent() = _InitialEvent;
}

@freezed
class ClickSearchEvent extends SearchbandEvent with _$ClickSearchEvent {
  const factory ClickSearchEvent() = _ClickSearchEvent;
}

@freezed
class TextSearchChanged extends SearchbandEvent with _$TextSearchChanged {
  factory TextSearchChanged(String value) = _TextSearchChanged;
}

@freezed
class ClickHistoryItem extends SearchbandEvent with _$ClickHistoryItem {
  const factory ClickHistoryItem({
    required String text,
  }) = _ClickHistoryItem;
}

@freezed
class ClickRemoveHistoryItem extends SearchbandEvent
    with _$ClickRemoveHistoryItem {
  const factory ClickRemoveHistoryItem({
    required int index,
  }) = _ClickRemoveHistoryItem;
}

@freezed
class ClearTextSearchInput extends SearchbandEvent with _$ClearTextSearchInput {
  const factory ClearTextSearchInput() = _ClearTextSearchInput;
}

@freezed
class RefreshPage extends SearchbandEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}

@freezed
class ClickRemoveAllHistory extends SearchbandEvent
    with _$ClickRemoveAllHistory {
  factory ClickRemoveAllHistory() = _ClickRemoveAllHistory;
}
