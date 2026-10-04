import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../data/data_sources/remotes/post_service.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../post/domain/entities/tag_entity.dart';
import '../../../../post/domain/usecase/create_question_usecase.dart';
import '../../../../post/domain/usecase/create_tag_usecase.dart';
import '../../../../post/domain/usecase/get_tag_usecase.dart';

part 'post_discussion_event.dart';
part 'post_discussion_state.dart';
part 'post_discussion_bloc.freezed.dart';

@Injectable()
class PostDiscussionBloc
    extends BaseBloc<PostDiscussionEvent, PostDiscussionState> {
  PostDiscussionBloc(
      this._getTagUseCase, this._createQuestionUseCase, this._createTagUseCase)
      : super(const PostDiscussionState()) {
    on<DescriptionChangedEvent>(_descriptionChanged);
    on<TitleChangedEvent>(_titleChanged);
    on<ClickClearImageEvent>(_clearImage);
    on<PickImageCameraEvent>(_pickImageCamera);
    on<PickImageGalleryEvent>(_pickImageGallery);
    on<ClickCreateTagEvent>(_createTag);
    on<ClickPostQuestionEvent>(_createQuestion);
    on<ClickSelectTagEvent>(_clickSelectTag);
    on<ClickRemoveTagEvent>(_clickRemoveTag);
    on<TagChangedEvent>(_getTag);
    on<ListenerFocusNodeEvent>(_listenerFocusNode);
    on<ClickCropEvent>(_cropImage);
    on<InitPage>(_initPage);
    on<AuDientChanged>(_audienceChanged);
  }

  final GetTagUseCase _getTagUseCase;
  final CreateQuestionUseCase _createQuestionUseCase;
  final CreateTagUseCase _createTagUseCase;

  FutureOr<void> _audienceChanged(
      AuDientChanged event, Emitter<PostDiscussionState> emit) async {
    emit(state.copyWith(audience: event.value));
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<PostDiscussionState> emit) async {
    String audience =
        LocalStorage.getStringValue(SharedPreferenceKeys.audience);
    audience = audience.isEmpty ? "public" : audience;

    emit(state.copyWith(audience: audience));
  }

  Future<void> _cropImage(
      ClickCropEvent event, Emitter<PostDiscussionState> emit) async {
    final croppedFile = await cropImage(state.originalImage!);
    emit(state.copyWith(image: croppedFile));
  }

  Future<void> _listenerFocusNode(
      ListenerFocusNodeEvent event, Emitter<PostDiscussionState> emit) async {
    emit(state.copyWith(isFocus: event.focus));
    debugPrint("isFocus ${state.isFocus}");
  }

  FutureOr<void> _createTag(
      ClickCreateTagEvent event, Emitter<PostDiscussionState> emit) async {
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

  void _validationPost(Emitter<PostDiscussionState> emit) {
    try {
      if (state.selectTags.isNotEmpty &&
          ((state.title.isNotEmpty && state.description.isNotEmpty) ||
              (state.image != null && state.description.isNotEmpty) ||
              (state.image != null && state.title.isNotEmpty))) {
        emit(
          state.copyWith(isValidatePost: false),
        );
      } else {
        emit(state.copyWith(isValidatePost: true));
      }
      debugPrint("selected list -----------------------");
      debugPrint("selected list ${state.selectTags.length}");
      debugPrint("selected list ${state.title.length}");
      debugPrint("selected list ${state.description.length}");
    } catch (vd) {
      debugPrint("_validationPost on catch $vd");
    }
  }

  FutureOr<void> _createQuestion(
      ClickPostQuestionEvent event, Emitter<PostDiscussionState> emit) async {
    await runAppCatching(
      () async {
        appRoute.pop();
        String imageBase64 = await imageToBase64(state.image);
        await _createQuestionUseCase.excecute(CreateQuestionInput(
          band_id: event.bandId,
          is_discussion: true,
          title: cleanText(state.title),
          description: cleanText(state.description),
          image: imageBase64,
          tags: state.selectTags.map((tag) => tag.id).toList(),
          visibility: state.audience,
        ));
        appRoute.showSuccessSnackBar(t.post.createSuccess);
      },
      onError: (error) async {
        debugPrint("create : $error");
      },
    );
  }

  FutureOr<void> _clearImage(
      ClickClearImageEvent event, Emitter<PostDiscussionState> emit) {
    emit(state.copyWith(image: null));
    _validationPost(emit);
  }

  FutureOr<void> _getTag(
      TagChangedEvent event, Emitter<PostDiscussionState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(tagtext: event.value));
        final tag = await _getTagUseCase
            .excecute(TagInput(oldTag: state.oldTag, name: event.value));
        emit(state.copyWith(tag: tag));
        debugPrint("tag  ${state.tag.length}");
      },
      onError: (error) async {
        debugPrint("you have been error $error");
      },
    );
  }

  FutureOr<void> _clickSelectTag(
      ClickSelectTagEvent event, Emitter<PostDiscussionState> emit) {
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
      ));
      _validationPost(emit);
    } catch (value) {
      debugPrint("catcsadfsdfh $value");
    }
  }

  FutureOr<void> _clickRemoveTag(
      ClickRemoveTagEvent event, Emitter<PostDiscussionState> emit) {
    final selectTag = [...state.selectTags];
    final oldSelectTag = [...state.oldTag];
    selectTag.removeAt(event.index);
    oldSelectTag.removeAt(event.index);
    emit(state.copyWith(selectTags: selectTag, oldTag: oldSelectTag));

    _validationPost(emit);
  }

  FutureOr<void> _pickImageCamera(
      PickImageCameraEvent event, Emitter<PostDiscussionState> emit) async {
    final file = await pickImage(source: ImageSource.camera);
    emit(state.copyWith(image: file, originalImage: file));
    _validationPost(emit);
  }

  FutureOr<void> _pickImageGallery(
      PickImageGalleryEvent event, Emitter<PostDiscussionState> emit) async {
    final file = await pickImage(source: ImageSource.gallery);
    emit(state.copyWith(image: file, originalImage: file));
    _validationPost(emit);
  }

  FutureOr<void> _titleChanged(
      TitleChangedEvent event, Emitter<PostDiscussionState> emit) async {
    emit(state.copyWith(title: event.value));
    _validationPost(emit);
  }

  FutureOr<void> _descriptionChanged(
      DescriptionChangedEvent event, Emitter<PostDiscussionState> emit) async {
    emit(state.copyWith(description: event.value));
    debugPrint(state.description);
    _validationPost(emit);
  }
}
