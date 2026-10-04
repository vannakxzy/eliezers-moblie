part of 'edit_category_bloc.dart';

@freezed
class EditCategoryState extends BaseState with _$EditCategoryState {
  const factory EditCategoryState({
    @Default(false) bool isLoading,
    @Default(false) bool enableBotton,
    @Default('') String oldBookName,
    CategoryEntity? category,
    @Default('') String bookName,
    @Default('') String urlCover,
    TextEditingController? bookNameText,
    File? fileCover,
  }) = _Initial;
}
