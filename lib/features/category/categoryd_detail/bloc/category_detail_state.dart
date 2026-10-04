part of 'category_detail_bloc.dart';

@freezed
class CategoryDetailState extends BaseState with _$CategoryDetailState {
  const factory CategoryDetailState({
    @Default('') String title,
    @Default('') String oldBookName,
    @Default('') String bookName,
    @Default([]) List<QuestionEntity> question,
    @Default(false) bool isloaing,
    @Default(1) int page,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
