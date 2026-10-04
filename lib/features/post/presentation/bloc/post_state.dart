part of 'post_bloc.dart';

@freezed
class PostState extends BaseState with _$PostState {
  const factory PostState({
    @Default([]) List<TagEntity> tag,
    @Default([]) List<int> oldTag,
    FocusNode? focusNode,
    @Default([]) List<TagEntity> selectTags,
    File? image,
    File? originalImage,
    @Default(true) isValidatePost,
    @Default(false) isFocus,
    @Default(false) isLoadingCreateTag,
    @Default('') String tagtext,
    @Default('') String title,
    @Default('') String audience,
    @Default('') String description,
    TextEditingController? titleTextEditController,
    TextEditingController? tagTextController,
    TextEditingController? descriptionTextController,
  }) = _Initial;
}
