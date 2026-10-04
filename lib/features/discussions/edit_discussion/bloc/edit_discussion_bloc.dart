import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/question_detail_service.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../question_detail/domain/usecase/update_question_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/post_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../post/domain/entities/tag_entity.dart';
import '../../../post/domain/usecase/create_tag_usecase.dart';
import '../../../post/domain/usecase/get_tag_usecase.dart';

part 'edit_discussion_event.dart';
part 'edit_discussion_state.dart';
part 'edit_discussion_bloc.freezed.dart';

@Injectable()
class EditDiscussionBloc
    extends BaseBloc<EditDiscussionEvent, EditDiscussionState> {
  EditDiscussionBloc(
      this._getTagUseCase, this._createTagUseCase, this._updateQuestionUsecase)
      : super(const EditDiscussionState()) {
    on<DescriptionChangedEvent>(_descriptionChanged);
    on<TitleChangedEvent>(_titleChanged);
    on<ClickClearImageEvent>(_clearImage);
    on<PickImageCameraEvent>(_pickImageCamera);
    on<PickImageGalleryEvent>(_pickImageGallery);
    on<ClickCreateTagEvent>(_createTag);
    on<ClickUpdateQuestionEvent>(_updateQuestion);
    on<ClickSelectTagEvent>(_clickSelectTag);
    on<ClickRemoveTagEvent>(_clickRemoveTag);
    on<TagChangedEvent>(_getTag);
    on<ListenerFocusNodeEvent>(_listenerFocusNode);
    on<InitPageEvent>(_initPageEvent);
    on<ClickCropEvent>(_cropImage);
    on<AuienceChanged>(_audienceChange);
  }

  final GetTagUseCase _getTagUseCase;
  final CreateTagUseCase _createTagUseCase;
  final UpdateQuestionUsecase _updateQuestionUsecase;

  Future<void> _initPageEvent(
      InitPageEvent event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(
        oldTag: event.question.tags.map((tag) => tag.id).toList(),
        image: event.question.file,
        selectTags: event.question.tags,
        audience: event.question.visibility,
        description: event.question.description,
        title: event.question.title,
        urlImage: event.question.image,
        questionId: event.question.id,
        descriptionTextController:
            TextEditingController(text: event.question.description),
        titleTextEditController:
            TextEditingController(text: event.question.title),
        question: event.question,
        oldQuestion: event.question));
    debugPrint("isFocus ${state.isFocus}");
  }

  Future<void> _listenerFocusNode(
      ListenerFocusNodeEvent event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(isFocus: event.focus));
    debugPrint("isFocus ${state.isFocus}");
  }

  FutureOr<void> _cropImage(
      ClickCropEvent event, Emitter<EditDiscussionState> emit) async {
    final newImage = await cropImage(state.image!);
    emit(state.copyWith(image: newImage));
  }

  FutureOr<void> _audienceChange(
      AuienceChanged event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(
        audience: event.value,
        question: state.question!.copyWith(visibility: event.value)));
    _validationPost(emit);
  }

  FutureOr<void> _createTag(
      ClickCreateTagEvent event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(isLoadingCreateTag: true));
    final newTag = await _createTagUseCase.excecute(event.value);
    emit(state.copyWith(isLoadingCreateTag: false));
    _clickSelectTag(
      ClickSelectTagEvent(TagEntity(
        id: newTag.id,
        name: newTag.name,
        subject_id: newTag.subject_id,
      )),
      emit,
    );
  }

  FutureOr<void> _validationPost(Emitter<EditDiscussionState> emit) {
    try {
      if ((state.selectTags.isNotEmpty &&
              ((state.title.isNotEmpty && state.description.isNotEmpty) ||
                  (state.image != null && state.description.isNotEmpty) ||
                  (state.image != null && state.title.isNotEmpty) ||
                  (state.urlImage != '' && state.title.isNotEmpty) ||
                  (state.urlImage != '' && state.description.isNotEmpty ||
                      state.audience != ""))) &&
          state.oldQuestion != state.question) {
        emit(
          state.copyWith(isValidatePost: false),
        );
      } else {
        emit(state.copyWith(isValidatePost: true));
      }
      debugPrint("${state.oldQuestion!.tags.first}");
      debugPrint("${state.question!.tags.first}");
    } catch (vd) {
      debugPrint("_validationPost on catch $vd");
    }
  }

  FutureOr<void> _updateQuestion(
      ClickUpdateQuestionEvent event, Emitter<EditDiscussionState> emit) async {
    await runAppCatching(
      () async {
        List<int> tagList = [];
        for (int i = 0; i < state.selectTags.length; ++i) {
          tagList.add(state.selectTags[i].id);
        }
        appRoute.pop(result: state.question!.copyWith(isUpdated: true));
        String imageBase64 = await imageToBase64(state.image);
        final UpdateQuestionInput newQuestion;
        newQuestion = UpdateQuestionInput(
            description: state.description,
            image: state.image == null ? state.question!.image : imageBase64,
            tags: tagList,
            title: state.title,
            id: state.questionId,
            visibility: state.audience);
        await _updateQuestionUsecase.excecute(newQuestion);
        appRoute.showSuccessSnackBar(t.common.updateQuestionSuccess);
      },
      onError: (error) async {
        debugPrint("you have been error $error ");
      },
    );
  }

  FutureOr<void> _clearImage(
      ClickClearImageEvent event, Emitter<EditDiscussionState> emit) {
    emit(state.copyWith(
        image: null,
        urlImage: '',
        question: state.question!.copyWith(image: '', file: null)));
    _validationPost(emit);
  }

  FutureOr<void> _getTag(
      TagChangedEvent event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(tagtext: event.value));
    final tag = await _getTagUseCase
        .excecute(TagInput(oldTag: state.oldTag, name: event.value));
    emit(state.copyWith(
        tag: tag, question: state.question!.copyWith(tags: tag)));
  }

  FutureOr<void> _clickSelectTag(
      ClickSelectTagEvent event, Emitter<EditDiscussionState> emit) {
    try {
      final tag = [...state.selectTags];
      final oldTag = [...state.oldTag];
      oldTag.add(event.tags.id);
      tag.add(event.tags);
      emit(state.copyWith(
          selectTags: tag,
          oldTag: oldTag,
          tagtext: "",
          tagTextController: TextEditingController(text: ''),
          question: state.question!.copyWith(tags: tag)));
      _validationPost(emit);
    } catch (value) {
      debugPrint("catch $value");
    }
  }

  FutureOr<void> _clickRemoveTag(
      ClickRemoveTagEvent event, Emitter<EditDiscussionState> emit) {
    final selectTag = [...state.selectTags];
    final oldSelectTag = [...state.oldTag];
    selectTag.removeAt(event.index);
    oldSelectTag.removeAt(event.index);
    emit(state.copyWith(
        oldTag: oldSelectTag,
        selectTags: selectTag,
        question: state.question!.copyWith(tags: selectTag)));
    _validationPost(emit);
  }

  FutureOr<void> _pickImageCamera(
      PickImageCameraEvent event, Emitter<EditDiscussionState> emit) async {
    final file = await pickImage(source: ImageSource.camera);
    emit(state.copyWith(
        image: file, question: state.question!.copyWith(file: file)));
    _validationPost(emit);
  }

  FutureOr<void> _pickImageGallery(
      PickImageGalleryEvent event, Emitter<EditDiscussionState> emit) async {
    final file = await pickImage(source: ImageSource.gallery);
    emit(state.copyWith(
        urlImage: "",
        image: file,
        question: state.question!.copyWith(file: file)));
    _validationPost(emit);
  }

  FutureOr<void> _titleChanged(
      TitleChangedEvent event, Emitter<EditDiscussionState> emit) async {
    debugPrint("title ${state.title}");
    emit(state.copyWith(
        title: event.value,
        question: state.question!.copyWith(title: event.value)));
    _validationPost(emit);
  }

  FutureOr<void> _descriptionChanged(
      DescriptionChangedEvent event, Emitter<EditDiscussionState> emit) async {
    emit(state.copyWith(
        description: event.value,
        question: state.question!.copyWith(description: event.value)));
    _validationPost(emit);
  }
}
