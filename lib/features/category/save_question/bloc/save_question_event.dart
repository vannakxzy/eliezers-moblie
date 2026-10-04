part of 'save_question_bloc.dart';

class SaveQuestionEvent extends BaseEvent {}

@freezed
class GetCategoryEvent extends SaveQuestionEvent with _$GetCategoryEvent {
  factory GetCategoryEvent() = _GetCategoryEvent;
}

@freezed
class CreateSaveQuestionToCategory extends SaveQuestionEvent
    with _$CreateSaveQuestionToCategory {
  factory CreateSaveQuestionToCategory({
    required int categoryId,
    required int questionId,
  }) = _CreateSaveQuestionToCategory;
}
