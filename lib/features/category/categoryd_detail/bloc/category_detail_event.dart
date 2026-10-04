part of 'category_detail_bloc.dart';

class CategoryDetailEvent extends BaseEvent {}

@freezed
class GetQuestioninCategoryEvent extends CategoryDetailEvent
    with _$GetQuestioninCategoryEvent {
  factory GetQuestioninCategoryEvent(int id) = _GetQuestioninCategoryEvent;
}

@freezed
class TitleChangedEvent extends CategoryDetailEvent with _$TitleChangedEvent {
  factory TitleChangedEvent(String title) = _TitleChangedEvent;
}

@freezed
class ClickLike extends CategoryDetailEvent with _$ClickLike {
  factory ClickLike(int index) = _ClickLike;
}

@freezed
class ClickUnLike extends CategoryDetailEvent with _$ClickUnLike {
  factory ClickUnLike(int index) = _ClickUnLike;
}

@freezed
class ClickHide extends CategoryDetailEvent with _$ClickHide {
  factory ClickHide(int index) = _ClickHide;
}

@freezed
class ClickUnHide extends CategoryDetailEvent with _$ClickUnHide {
  factory ClickUnHide(int index) = _ClickUnHide;
}

@freezed
class ClickDoubleTap extends CategoryDetailEvent with _$ClickDoubleTap {
  factory ClickDoubleTap(int index) = _ClickDoubleTap;
}

@freezed
class ClickSave extends CategoryDetailEvent with _$ClickSave {
  factory ClickSave(int index) = _ClickSave;
}

@freezed
class ClickQuestion extends CategoryDetailEvent with _$ClickQuestion {
  factory ClickQuestion(QuestionEntity question, int id) = _ClickQuestion;
}

@freezed
class Refreshpage extends CategoryDetailEvent with _$Refreshpage {
  factory Refreshpage(int id) = _Refreshpage;
}

@freezed
class ClickShareQuestion extends CategoryDetailEvent with _$ClickShareQuestion {
  factory ClickShareQuestion(QuestionEntity question) = _ClickShareQuestion;
}
