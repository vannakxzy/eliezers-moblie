part of 'discussions_bloc.dart';

@freezed
class DiscussionsState extends BaseState with _$DiscussionsState {
  const factory DiscussionsState({
    @Default(false) bool isLoading,
    @Default([]) List<QuestionEntity> discussion,
    @Default(1) int page,
    @Default(true) bool isMorePage,
    @Default(0) int indexFilterDate,
    TextEditingController? searchText,
    @Default(FilterEntity()) FilterEntity filter,
  }) = _Initial;
}
