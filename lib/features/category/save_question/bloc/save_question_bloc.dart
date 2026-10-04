// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../domain/usecase/get_category_usecase.dart';

import '../../../../data/data_sources/remotes/category_service.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecase/save_question_to_category_usercase.dart';

part 'save_question_event.dart';
part 'save_question_state.dart';
part 'save_question_bloc.freezed.dart';

@Injectable()
class SaveQuestionBloc extends BaseBloc<SaveQuestionEvent, SaveQuestionState> {
  SaveQuestionBloc(
      this._GetCategoryEventUsecase, this._saveQuestionToCategoryUserCase)
      : super(const SaveQuestionState()) {
    on<GetCategoryEvent>(_GetCategoryEvent);
    on<CreateSaveQuestionToCategory>(_createSaveQuestionToCategory);
  }
  final SaveQuestionToCategoryUserCase _saveQuestionToCategoryUserCase;

  final GetCategoryEventUsecase _GetCategoryEventUsecase;

  FutureOr<void> _GetCategoryEvent(
      GetCategoryEvent event, Emitter<SaveQuestionState> emit) async {
    await runAppCatching(
      () async {
        await runAppCatching(() async {
          emit(state.copyWith(isloading: true));
          final category = await _GetCategoryEventUsecase.excecute('');
          emit(state.copyWith(category: category, isloading: false));
        });
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _createSaveQuestionToCategory(
      CreateSaveQuestionToCategory event,
      Emitter<SaveQuestionState> emit) async {
    await runAppCatching(() async {
      await _saveQuestionToCategoryUserCase.excecute(SaveQuestionInput(
        question_id: event.questionId,
        save_category_id: event.categoryId,
      ));
    });
  }
}
