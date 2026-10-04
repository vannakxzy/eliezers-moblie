part of 'all_book_bloc.dart';

@freezed
class AllBookState extends BaseState with _$AllBookState {
  const factory AllBookState({
    @Default([]) List<List<QuestionEntity>> questions,
    @Default([]) List<bool> isloading,
    @Default([]) List<int> page,
    @Default([]) List<bool> isMorePage,
    @Default([]) List<ScrollController> scrollController,
  }) = _Initial;
}
