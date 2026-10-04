part of 'create_category_bloc.dart';

@freezed
class CreateCategoryState extends BaseState with _$CreateCategoryState {
  const factory CreateCategoryState({
    @Default(false) bool isloading,
    @Default(false) bool enableBotton,
    @Default('') String bookName,
    TextEditingController? bookNameTextEditController,
    File? bookCover,
  }) = _Initial;
}
