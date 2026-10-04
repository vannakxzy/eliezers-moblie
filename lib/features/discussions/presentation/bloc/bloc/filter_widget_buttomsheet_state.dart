part of 'filter_widget_buttomsheet_bloc.dart';

@freezed
class FilterWidgetButtomsheetState extends BaseState
    with _$FilterWidgetButtomsheetState {
  const factory FilterWidgetButtomsheetState({
    TextEditingController? searchText,
    @Default([]) List<TagEntity> tags,
    @Default(FilterEntity()) FilterEntity filter,
    @Default(0) int resultCount,
    @Default(0) int bandId,
  }) = _Initial;
}
