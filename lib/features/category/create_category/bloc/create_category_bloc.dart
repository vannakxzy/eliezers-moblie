import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecase/create_category_usercase.dart';

import '../../../../gen/i18n/translations.g.dart';
import '../../domain/usecase/save_question_to_category_usercase.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';
part 'create_category_bloc.freezed.dart';

@Injectable()
class CreateCategoryBloc
    extends BaseBloc<CreateCategoryEvent, CreateCategoryState> {
  CreateCategoryBloc(
      this._createCategoryUserCase, this._saveQuestionToCategoryUserCase)
      : super(const _Initial()) {
    on<ClickCreateEvent>(_clickCreateEventCategory);
    on<BookNameChangedEvent>(_bookNameChangedEvent);
    on<ClickPickCoverEvent>(_pickCover);
    on<ClickClearCoverEvent>(_clearCover);
  }
  final CreateCategoryUserCase _createCategoryUserCase;
  final SaveQuestionToCategoryUserCase _saveQuestionToCategoryUserCase;

  FutureOr<void> _clearCover(
      ClickClearCoverEvent event, Emitter<CreateCategoryState> emit) {
    emit(state.copyWith(bookCover: null));
    _enableBotton(emit);
  }

  FutureOr<void> _bookNameChangedEvent(
      BookNameChangedEvent event, Emitter<CreateCategoryState> emit) {
    emit(state.copyWith(bookName: event.value));
    _enableBotton(emit);
  }

  Future<void> _pickCover(
      ClickPickCoverEvent event, Emitter<CreateCategoryState> emit) async {
    emit(state.copyWith(bookCover: event.image));
    _enableBotton(emit);
  }

  void _enableBotton(Emitter<CreateCategoryState> emit) {
    if (state.bookName.isNotEmpty || state.bookCover != null) {
      emit(state.copyWith(enableBotton: true));
    } else {
      emit(state.copyWith(enableBotton: false));
    }
  }

  FutureOr<void> _clickCreateEventCategory(
      ClickCreateEvent event, Emitter<CreateCategoryState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(isloading: true));
      try {
        String cover = await imageToBase64(state.bookCover);
        CategoryEntity newCategory = await _createCategoryUserCase
            .excecute(CreateCategoryInput(cover: cover, name: state.bookName));
        if (event.questionId != 0) {
          await _saveQuestionToCategoryUserCase.excecute(SaveQuestionInput(
              question_id: event.questionId, save_category_id: newCategory.id));
        }
        appRoute.pop(result: newCategory);
        // Navigator.pop(event.context, true);
        emit(state.copyWith(isloading: false));
        _enableBotton(emit);
      } catch (e) {
        emit(state.copyWith(isloading: false));
        appRoute.showErrorSnackBar("${t.book.createFail}\n\n $e ");
        debugPrint("you on cahge $e");
      }
    });
  }
}
