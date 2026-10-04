part of 'category_bloc.dart';

class CategoryEvent extends BaseEvent {}

@freezed
class GetCategoryEvent extends CategoryEvent with _$GetCategoryEvent {
  factory GetCategoryEvent() = _GetCategoryEvent;
}

@freezed
class Reordered extends CategoryEvent with _$Reordered {
  factory Reordered(int oldIndex, int newIndex) = _Reordered;
}

@freezed
class MergeCategoryEvent extends CategoryEvent with _$MergeCategoryEvent {
  factory MergeCategoryEvent({required int fromIndex, required int toIndex}) =
      _MergeCategoryEvent;
}

@freezed
class DeleteCategoryEvent extends CategoryEvent with _$DeleteCategoryEvent {
  factory DeleteCategoryEvent(int index) = _DeleteCategoryEvent;
}

@freezed
class UpdateCategoryEvent extends CategoryEvent with _$UpdateCategoryEvent {
  factory UpdateCategoryEvent({int? index, String? name, String? cover}) =
      _UpdateCategoryEvent;
}

@freezed
class ClickUpdateCategoryEvent extends CategoryEvent
    with _$ClickUpdateCategoryEvent {
  factory ClickUpdateCategoryEvent(
      {required String bookName,
      required int index,
      required String cover}) = _ClickUpdateCategoryEvent;
}

@freezed
class ClickDeletecategoryEvent extends CategoryEvent
    with _$ClickDeletecategoryEvent {
  factory ClickDeletecategoryEvent(int index) = _ClickDeletecategoryEvent;
}

@freezed
class ClickMergeCategoryEvent extends CategoryEvent
    with _$ClickMergeCategoryEvent {
  factory ClickMergeCategoryEvent(
      {required int formIndex,
      required int toIndex}) = _ClickMergeCategoryEvent;
}

@freezed
class ClickCreateCategory extends CategoryEvent with _$ClickCreateCategory {
  factory ClickCreateCategory() = _ClickCreateCategory;
}
