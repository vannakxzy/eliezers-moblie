import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../../app/base/bloc/base_event.dart';
import '../../../../../../app/base/bloc/base_state.dart';
import '../../../../../../core/helper/fuction.dart';
import '../../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../../data/models/question_model.dart';
import '../../../../domain/usecase/get_question_by_tag_usecase.dart';
import '../../../../../security_login/domain/usecase/un_hide_by_questionId.dart';

import '../../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../category/domain/usecase/delete_save_question.dart';
import '../../../../../home/domain/entities/question_entity.dart';
import '../../../../../home/domain/usecase/like_question_usecase.dart';
import '../../../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../../../security_login/domain/usecase/create_hide_usercase.dart';

part 'question_tag_event.dart';
part 'question_tag_state.dart';
part 'question_tag_bloc.freezed.dart';

@Injectable()
class QuestionTagBloc extends BaseBloc<QuestionTagEvent, QuestionTagState> {
  QuestionTagBloc(
      this._getQuestionByTagUsecase,
      this._createHideUsercase,
      this._unHideUsecase,
      this._likeQuestionUseCase,
      this._unLikeQuestion,
      this._deleteSaveQuestionUseCase)
      : super(const _Initial()) {
    on<GetQuestion>(_getResultSearch);
    on<ClickHideEventp>(_clickHide);
    on<ClickUnHideEventT>(_clickUnHide);
    on<ClickLikeEventT>(_clickLike);
    on<ClickQuestionEvent>(_clickQuestion);
    on<OnRefreshPageEvent>(_onRefreshpage);
    on<ClickSaveQuestionT>(_clickSaveQuestion);
    on<ClickShareQuestion>(_clickShareQuestion);
  }
  final GetQuestionByTagUsecase _getQuestionByTagUsecase;
  final CreateHideUsercase _createHideUsercase;
  final UnHideByQuestionidUseCase _unHideUsecase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;

  final UnLikeQuestion _unLikeQuestion;
  FutureOr<void> _clickShareQuestion(
      ClickShareQuestion event, Emitter<QuestionTagState> emit) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _getResultSearch(
      GetQuestion event, Emitter<QuestionTagState> emit) async {
    if (event.tagId != 0) {
      await runAppCatching(() async {
        try {
          emit(state.copyWith(loaingQuestion: true));
          final questionRepose = await _getQuestionByTagUsecase.excecute(
              GetQuestionByTagInput(tag_id: event.tagId, page: state.page));
          List<QuestionEntity> all = [...state.questions];
          all.addAll(questionRepose.data.toListEntity());
          emit(state.copyWith(
            questions: all,
            loaingQuestion: false,
            page: state.page + 1,
          ));
          if (state.page > questionRepose.mate!.lastPage) {
            emit(state.copyWith(isMorePage: false));
          }
        } catch (e) {
          debugPrint("you have on catch$e ");
          emit(state.copyWith(loaingQuestion: false));
        }
      });
      return null;
    }
  }

  FutureOr<void> _clickSaveQuestion(
      ClickSaveQuestionT event, Emitter<QuestionTagState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.questions];
        final currentQuestion = questions[event.index];
        questions[event.index] =
            currentQuestion.copyWith(is_saved: !currentQuestion.is_saved);
        emit(state.copyWith(questions: questions));
        if (currentQuestion.is_saved == true) {
          await _deleteSaveQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
    return null;
  }

  FutureOr<void> _clickQuestion(
      ClickQuestionEvent event, Emitter<QuestionTagState> emit) async {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.question));
    return null;
  }

  FutureOr<void> _clickHide(
      ClickHideEventp event, Emitter<QuestionTagState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.questions];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: true);
        emit(state.copyWith(questions: question));
        await _createHideUsercase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
    return null;
  }

  FutureOr<void> _clickUnHide(
      ClickUnHideEventT event, Emitter<QuestionTagState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.questions];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: false);
        // question.removeAt(event.index);
        emit(state.copyWith(questions: question));
        await _unHideUsecase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
    return null;
  }

  FutureOr<void> _clickLike(
      ClickLikeEventT event, Emitter<QuestionTagState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.questions];
        final currentQuestion = questions[event.index];
        final currentLikes = currentQuestion.countLike;
        if (currentQuestion.is_like == false) {
          questions[event.index] = currentQuestion.copyWith(
            is_like: true,
            countLike: currentLikes + 1,
          );
          emit(state.copyWith(questions: questions));
          debugPrint("${questions[event.index]}");
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        } else {
          questions[event.index] = currentQuestion.copyWith(
              countLike: currentLikes - 1, is_like: false);
          emit(state.copyWith(questions: questions));
          debugPrint("dddddddddddd${questions[event.index].is_like}");
          await _unLikeQuestion.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
    return null;
  }

  FutureOr<void> _onRefreshpage(
      OnRefreshPageEvent event, Emitter<QuestionTagState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loaingQuestion: true, page: 1, isMorePage: true));
        final questionRepose = await _getQuestionByTagUsecase.excecute(
            GetQuestionByTagInput(tag_id: event.tagId, page: state.page));
        emit(state.copyWith(
          questions: questionRepose.data.toListEntity(),
          loaingQuestion: false,
          page: state.page + 1,
        ));
        if (state.page > questionRepose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(loaingQuestion: false));
      },
    );
    return null;
  }
}
