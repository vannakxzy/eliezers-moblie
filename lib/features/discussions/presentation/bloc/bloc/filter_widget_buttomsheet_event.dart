part of 'filter_widget_buttomsheet_bloc.dart';

class FilterWidgetButtomsheetEvent extends BaseEvent {}

@freezed
class SearchTag extends FilterWidgetButtomsheetEvent with _$SearchTag {
  factory SearchTag(String value) = _SearchTag;
}

@freezed
class ClickType extends FilterWidgetButtomsheetEvent with _$ClickType {
  factory ClickType(String value) = _ClickType;
}

@freezed
class SelectTag extends FilterWidgetButtomsheetEvent with _$SelectTag {
  factory SelectTag(int index) = _SelectTag;
}

@freezed
class ClearTag extends FilterWidgetButtomsheetEvent with _$ClearTag {
  factory ClearTag(int index) = _ClearTag;
}

@freezed
class ClearAllTag extends FilterWidgetButtomsheetEvent with _$ClearAllTag {
  factory ClearAllTag() = _ClearAllTag;
}

@freezed
class ClickDate extends FilterWidgetButtomsheetEvent with _$ClickDate {
  factory ClickDate(String value) = _ClickDate;
}

@freezed
class ClickLike extends FilterWidgetButtomsheetEvent with _$ClickLike {
  factory ClickLike(String value) = _ClickLike;
}

@freezed
class ClickStatus extends FilterWidgetButtomsheetEvent with _$ClickStatus {
  factory ClickStatus(String value) = _ClickStatus;
}

@freezed
class ClickApplyFilter extends FilterWidgetButtomsheetEvent
    with _$ClickApplyFilter {
  factory ClickApplyFilter() = _ClickApplyFilter;
}

@freezed
class ClearFilter extends FilterWidgetButtomsheetEvent with _$ClearFilter {
  factory ClearFilter() = _ClearFilter;
}

@freezed
class ClickCancel extends FilterWidgetButtomsheetEvent with _$ClickCancel {
  factory ClickCancel() = _ClickCancel;
}

@freezed
class InitPage extends FilterWidgetButtomsheetEvent with _$InitPage {
  factory InitPage(FilterEntity filter) = _InitPage;
}
