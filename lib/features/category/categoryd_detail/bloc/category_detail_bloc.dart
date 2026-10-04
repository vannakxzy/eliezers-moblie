import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../../../../data/models/question_model.dart';
import '../../domain/usecase/get_quesiton_in_category.dart';
import '../../../home/domain/entities/question_entity.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../home/domain/usecase/like_question_usecase.dart';
import '../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../security_login/domain/usecase/un_hide_by_questionId.dart';
import '../../domain/usecase/delete_save_question.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';
part 'category_detail_bloc.freezed.dart';

@Injectable()
class CategoryDetailBloc
    extends BaseBloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc(
      this._GetQuestioninCategoryEventUseCase,
      this._deleteSaveQuestionUseCase,
      this._unLikeQuestion,
      this._unHideByQuestionidUseCase,
      this._likeQuestionUseCase,
      this._createHideUsercase)
      : super(const CategoryDetailState()) {
    on<GetQuestioninCategoryEvent>(_GetQuestioninCategoryEvent);
    on<TitleChangedEvent>(_titleChagned);
    on<ClickSave>(_clickSave);
    on<ClickLike>(_clickLike);
    on<ClickDoubleTap>(_clickDoubleTap);
    on<ClickHide>(_clickHide);
    on<ClickUnHide>(_clickUnHide);
    on<Refreshpage>(_freshPage);
    on<ClickQuestion>(_clickQuestion);
    on<ClickShareQuestion>(_clickShareQuestion);
  }
  final GetQuestioninCategoryEventUseCase _GetQuestioninCategoryEventUseCase;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;
  final UnLikeQuestion _unLikeQuestion;
  final UnHideByQuestionidUseCase _unHideByQuestionidUseCase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final CreateHideUsercase _createHideUsercase;
  FutureOr<void> _clickShareQuestion(
      ClickShareQuestion event, Emitter<CategoryDetailState> emit) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _GetQuestioninCategoryEvent(GetQuestioninCategoryEvent event,
      Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloaing: true));
        final questionRespnose =
            await _GetQuestioninCategoryEventUseCase.excecute(
                IdPageInput(id: event.id, page: state.page));
        final all = [...state.question];
        all.addAll(questionRespnose.data.toListEntity());
        emit(state.copyWith(
            question: all, isloaing: false, page: state.page + 1));
        if (state.page > questionRespnose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloaing: false));
        debugPrint("your runing on errror $error");
      },
    );
  }

  FutureOr<void> _clickQuestion(
      ClickQuestion event, Emitter<CategoryDetailState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(id: event.question.id));
  }

  FutureOr<void> _freshPage(
      Refreshpage event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloaing: true, isMorePage: true, page: 1));
        final questionRespnose =
            await _GetQuestioninCategoryEventUseCase.excecute(
                IdPageInput(id: event.id, page: state.page));
        emit(state.copyWith(
            question: questionRespnose.data.toListEntity(),
            isloaing: false,
            page: state.page + 1));
        if (state.page > questionRespnose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloaing: false));
        debugPrint("your runing on errror $error");
      },
    );
  }

  FutureOr<void> _titleChagned(
      TitleChangedEvent event, Emitter<CategoryDetailState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _clickSave(
      ClickSave event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.question];
        final currentQuestion = questions[event.index];
        questions[event.index] =
            currentQuestion.copyWith(is_saved: !currentQuestion.is_saved);
        emit(state.copyWith(question: questions));
        if (currentQuestion.is_saved == true) {
          await _deleteSaveQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickHide(
      ClickHide event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.question];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: true);
        emit(state.copyWith(question: question));
        await _createHideUsercase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickUnHide(
      ClickUnHide event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.question];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: false);
        // question.removeAt(event.index);
        emit(state.copyWith(question: question));
        await _unHideByQuestionidUseCase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickDoubleTap(
      ClickDoubleTap event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.question];
        final currentQuestion = questions[event.index];
        final currentLikes = currentQuestion.countLike;
        if (currentQuestion.is_like == false) {
          questions[event.index] = currentQuestion.copyWith(
            is_like: true,
            countLike: currentLikes + 1,
          );
          emit(state.copyWith(question: questions));
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _clickLike(
      ClickLike event, Emitter<CategoryDetailState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.question];
        final currentQuestion = questions[event.index];
        final currentLikes = currentQuestion.countLike;
        if (currentQuestion.is_like == false) {
          questions[event.index] = currentQuestion.copyWith(
            is_like: true,
            countLike: currentLikes + 1,
          );
          emit(state.copyWith(question: questions));
          debugPrint("${questions[event.index]}");
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        } else {
          questions[event.index] = currentQuestion.copyWith(
              countLike: currentLikes - 1, is_like: false);
          emit(state.copyWith(question: questions));
          debugPrint("dddddddddddd${questions[event.index].is_like}");
          await _unLikeQuestion.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }
}
