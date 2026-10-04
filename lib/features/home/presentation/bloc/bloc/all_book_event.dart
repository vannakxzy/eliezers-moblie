part of 'all_book_bloc.dart';

class AllBookEvent extends BaseEvent {}

@freezed
class ClickQuestionEventd extends AllBookEvent with _$ClickQuestionEventd {
  factory ClickQuestionEventd(int id, QuestionEntity questionEntity) =
      _ClickQuestionEventd;
}

@freezed
class ClickDoubleTapTapPage extends AllBookEvent with _$ClickDoubleTapTapPage {
  factory ClickDoubleTapTapPage(int index) = _ClickDoubleTapTapPage;
}

@freezed
class RefreshPaged extends AllBookEvent with _$RefreshPaged {
  factory RefreshPaged(int index, String q) = _RefreshPage;
}

@freezed
class ClickUnhideQuestion extends AllBookEvent with _$ClickUnhideQuestion {
  factory ClickUnhideQuestion(int index, int categoryIndex) =
      _ClickUnhideQuestion;
}

@freezed
class GetQuestionEventd extends AllBookEvent with _$GetQuestionEventd {
  factory GetQuestionEventd(int index, String q) = _GetQuestionEventd;
}

@freezed
class InitPage extends AllBookEvent with _$InitPage {
  factory InitPage(List<CategoryEntity> category) = _InitPage;
}

@freezed
class ClickLikeQuestionByCategory extends AllBookEvent
    with _$ClickLikeQuestionByCategory {
  factory ClickLikeQuestionByCategory(int index, int categoryIndex) =
      _ClickLikeQuestionByCategory;
}

@freezed
class ClickSaveQuestiond extends AllBookEvent with _$ClickSaveQuestiond {
  factory ClickSaveQuestiond(int index, int categoryIndex) =
      _ClickSaveQuestiond;
}

@freezed
class ClickHideQuestionByCategory extends AllBookEvent
    with _$ClickHideQuestionByCategory {
  factory ClickHideQuestionByCategory(int index, int categoryIndex) =
      _ClickHideQuestionByCategory;
}

@freezed
class ClickDoubleTanQuestionByCategory extends AllBookEvent
    with _$ClickDoubleTanQuestionByCategory {
  factory ClickDoubleTanQuestionByCategory(int index, int categoryIndex) =
      _ClickDoubleTanQuestionByCategory;
}

@freezed
class ClickShareQuestion extends AllBookEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}
