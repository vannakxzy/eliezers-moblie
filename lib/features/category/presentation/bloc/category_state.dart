part of 'category_bloc.dart';

@freezed
class CategoryState extends BaseState with _$CategoryState {
  const factory CategoryState({
    @Default([]) List<CategoryEntity> category,
    @Default(true) bool isloading,
  }) = _CategoryState;
}
