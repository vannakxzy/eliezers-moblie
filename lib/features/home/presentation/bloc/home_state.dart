part of 'home_bloc.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  const factory HomeState({
    @Default(true) bool isLoading,
    @Default([]) List<QuestionEntity> questions,
    @Default([]) List<List<QuestionEntity>> questionsByCatrgory,
    @Default([]) List<bool> getQISloading,
    @Default(1) int page,
    @Default(0) int filterCount,
    @Default([]) List<CategoryEntity> category,
    @Default(true) bool isMorePage,
    @Default(false) bool showPost,
    @Default(FilterEntity()) FilterEntity filter,
  }) = _HomeState;
}
