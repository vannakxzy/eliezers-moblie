import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecase/edit_category_usercase.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../app/base/bloc/bloc.dart';

part 'edit_category_event.dart';
part 'edit_category_state.dart';
part 'edit_category_bloc.freezed.dart';

@Injectable()
class EditCategoryBloc extends BaseBloc<EditCategoryEvent, EditCategoryState> {
  EditCategoryBloc(this._editCategoryUseCase) : super(const _Initial()) {
    on<BookNameChangedEvent>(_bookNameChangedEvent);
    on<GetDefault>(_getDefault);
    on<ClickClearCoverEvent>(_clearCover);
    on<ClickPickCoverEvent>(_pickCover);
    on<ClickUpdate>(_updateCategory);
  }
  final EditCategoryUseCase _editCategoryUseCase;

  FutureOr<void> _bookNameChangedEvent(
      BookNameChangedEvent event, Emitter<EditCategoryState> emit) {
    emit(state.copyWith(bookName: event.value));
    _enableBotton(emit);
  }

  FutureOr<void> _getDefault(
      GetDefault event, Emitter<EditCategoryState> emit) {
    emit(state.copyWith(
        category: event.category,
        bookName: event.category.name ?? "",
        urlCover: event.category.cover!,
        oldBookName: event.category.name ?? "",
        bookNameText: TextEditingController(text: event.category.name)));
    _enableBotton(emit);
  }

  void _enableBotton(Emitter<EditCategoryState> emit) {
    CategoryEntity newCategory;
    newCategory =
        state.category!.copyWith(name: state.bookName, cover: state.urlCover);
    if (state.fileCover != null ||
        (newCategory != state.category &&
            (state.bookName.isNotEmpty || state.urlCover.isNotEmpty))) {
      emit(state.copyWith(enableBotton: true));
    } else {
      emit(state.copyWith(enableBotton: false));
    }
  }

  FutureOr<void> _pickCover(
      ClickPickCoverEvent event, Emitter<EditCategoryState> emit) async {
    final file = await pickImage(source: ImageSource.gallery);
    emit(state.copyWith(fileCover: file, urlCover: ''));
    _enableBotton(emit);
  }

  FutureOr<void> _clearCover(
      ClickClearCoverEvent event, Emitter<EditCategoryState> emit) async {
    emit(state.copyWith(fileCover: null, urlCover: ''));
    _enableBotton(emit);
  }

  FutureOr<void> _updateCategory(
      ClickUpdate event, Emitter<EditCategoryState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        String cover = await imageToBase64(state.fileCover);
        final category = await _editCategoryUseCase.excecute(EditCategoryInput(
          id: event.id,
          name: state.bookName,
          cover: state.fileCover == null ? state.urlCover : cover,
        ));
        debugPrint("category $category");
        appRoute.pop(result: category);
        emit(state.copyWith(isLoading: false));
        _enableBotton(emit);
        appRoute.showSuccessSnackBar(t.book.udpateSuccessMessage);
      },
      onError: (error) async {
        debugPrint("your eroor $error");
        emit(state.copyWith(isLoading: false));
        appRoute.showErrorSnackBar(t.book.udpateUnSuccessMessage);
      },
    );
  }
}
