import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../data/models/question_model.dart';
import '../../../../home/domain/entities/question_respose_entity.dart';
import '../../../../security_login/domain/usecase/un_hide_by_questionId.dart';

import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../../../../category/domain/usecase/delete_save_question.dart';
import '../../../../home/domain/entities/question_entity.dart';
import '../../../../home/domain/usecase/like_question_usecase.dart';
import '../../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../../profile/domain/entities/top_tag_entity.dart';
import '../../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../domain/usecase/get_own_question_by_tag.dart';
import '../../../domain/usecase/get_question_user_tag_usecase.dart';

part 'data_tag_question_event.dart';
part 'data_tag_question_state.dart';
part 'data_tag_question_bloc.freezed.dart';

@Injectable()
class DataTagQuestionBloc
    extends BaseBloc<DataTagQuestionEvent, DataTagQuestionState> {
  DataTagQuestionBloc(
      this._getOwnQuestionByTagUseCase,
      this._getQuesitonByUserByTagUseCase,
      this._createHideUsercase,
      this._unHideByQuestionidUseCase,
      this._deleteSaveQuestionUseCase,
      this._likeQuestionUseCase,
      this._unLikeQuestion)
      : super(const _Initial()) {
    on<RefreshPaged>(_rfreshPage);
    on<GetQuestionEventq>(_getQuestion);
    on<ClickQuestionEvetn>(_clickQuestion);
    on<ClickHideEvent>(_clickHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickLikeEvent>(_clickLike);
    on<InitPage>(_initPage);
    on<DoubleTapEvent>(_clickDoubleTap);
    on<ClickSaveQuesition>(_clickSaveQuestion);
    on<ClickShare>(_shareQuestion);
  }
  final GetOwnQuestionByTagUseCase _getOwnQuestionByTagUseCase;
  final GetQuesitonByUserByTagUseCase _getQuesitonByUserByTagUseCase;
  final CreateHideUsercase _createHideUsercase;
  final UnHideByQuestionidUseCase _unHideByQuestionidUseCase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final UnLikeQuestion _unLikeQuestion;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;
  FutureOr<void> _shareQuestion(
      ClickShare event, Emitter<DataTagQuestionState> emti) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _clickSaveQuestion(
      ClickSaveQuesition event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> question = state.question
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = question[event.tap][event.index];
        question[event.tap][event.index] =
            currentQuestion.copyWith(is_saved: !currentQuestion.is_saved);
        emit(state.copyWith(question: question));
        if (currentQuestion.is_saved) {
          await _deleteSaveQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickQuestion(
      ClickQuestionEvetn event, Emitter<DataTagQuestionState> emit) async {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.question));
  }

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> question = state.question
            .map((subjectQuestions) => [...subjectQuestions])
            .toList();
        final currentquestion = question[event.tap][event.index];
        question[event.tap][event.index] =
            currentquestion.copyWith(isHide: true);
        emit(state.copyWith(question: question));
        await _createHideUsercase.excecute(currentquestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickUnHide(
      ClickUnHideEvent event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> question = state.question
            .map((subjectQuestions) => [...subjectQuestions])
            .toList();
        final currentquestion = question[event.tap][event.index];
        question[event.tap][event.index] =
            currentquestion.copyWith(isHide: false);
        emit(state.copyWith(question: question));
        await _unHideByQuestionidUseCase.excecute(currentquestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickDoubleTap(
      DoubleTapEvent event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> question = state.question
            .map((subjectQuestions) => [...subjectQuestions])
            .toList();
        final currentQuestion = question[event.tap][event.index];
        if (currentQuestion.is_like == false) {
          final currentLike = currentQuestion.countLike;
          question[event.tap][event.index] = currentQuestion.copyWith(
            countLike: currentLike + 1,
            is_like: true,
          );
          emit(state.copyWith(question: question));
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _clickLike(
      ClickLikeEvent event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> question = state.question
            .map((subjectQuestions) => [...subjectQuestions])
            .toList();
        final currentQuestion = question[event.tap][event.index];
        if (currentQuestion.is_like == false) {
          final currentLike = currentQuestion.countLike;
          question[event.tap][event.index] = currentQuestion.copyWith(
            countLike: currentLike + 1,
            is_like: true,
          );
          emit(state.copyWith(question: question));
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        } else {
          final currentLike = currentQuestion.countLike;
          question[event.tap][event.index] = currentQuestion.copyWith(
            countLike: currentLike - 1,
            is_like: false,
          );
          emit(state.copyWith(question: question));
          await _unLikeQuestion.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _getQuestion(
      GetQuestionEventq event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final beforeLoaing = [...state.isloading];
        beforeLoaing[event.index] = true;
        emit(state.copyWith(isloading: beforeLoaing));
        QuestionResposeEntity questionRespose;
        if (event.userId > 0) {
          questionRespose = await _getQuesitonByUserByTagUseCase.excecute(
              UserIdTagIdInput(
                  tag_id: event.tagId,
                  user_id: event.userId,
                  page: state.page[event.index]));
        } else {
          questionRespose = await _getOwnQuestionByTagUseCase.excecute(
              TagIdInput(tag_id: event.tagId, page: state.page[event.index]));
        }
        final all = [...state.question];
        all[event.index].addAll(questionRespose.data.toListEntity());
        final loading = [...state.isloading];
        final page = [...state.page];
        page[event.index] = page[event.index] + 1;
        loading[event.index] = false;
        emit(state.copyWith(
          isloading: loading,
          question: all,
          page: page,
        ));
        if (state.page[event.index] > questionRespose.mate!.lastPage) {
          final isMore = [...state.isloading];
          isMore[event.index] = false;
          emit(state.copyWith(isMorePage: isMore));
        }
      },
      onError: (error) async {
        final loading = [...state.isloading];
        loading[event.index] = false;
        emit(state.copyWith(isloading: loading));
        debugPrint("get question error  $error");
      },
    );
    return null;
  }

  FutureOr<void> _initPage(InitPage event, Emitter<DataTagQuestionState> emit) {
    List<bool> qtLoading = List.filled(event.tag.length, true);
    List<bool> morepage = List.filled(event.tag.length, true);
    List<int> page = List.filled(event.tag.length, 1);
    List<List<QuestionEntity>> question = List.filled(event.tag.length, []);
    emit(state.copyWith(
        question: question,
        isloading: qtLoading,
        isMorePage: morepage,
        page: page));
    debugPrint(
        "tagaga${event.tag.length} ${state.question.length} ${state.isloading.length}");
  }

  FutureOr<void> _rfreshPage(
      RefreshPaged event, Emitter<DataTagQuestionState> emit) async {
    await runAppCatching(
      () async {
        final beforePage = [...state.page];
        final beforeLoading = [...state.isloading];
        final isMorePage = [...state.isMorePage];
        beforeLoading[event.index] = true;
        isMorePage[event.index] = true;
        beforePage[event.index] = 1;
        emit(state.copyWith(
            page: beforePage,
            isloading: beforeLoading,
            isMorePage: isMorePage));
        debugPrint("after ===${beforePage[event.index]}");

        QuestionResposeEntity questionRespose;
        if (event.userId > 0) {
          questionRespose = await _getQuesitonByUserByTagUseCase.excecute(
              UserIdTagIdInput(
                  tag_id: event.tagId,
                  user_id: event.userId,
                  page: state.page[event.index]));
        } else {
          questionRespose = await _getOwnQuestionByTagUseCase.excecute(
              TagIdInput(tag_id: event.tagId, page: state.page[event.index]));
        }
        final question = [...state.question];
        question[event.index] = questionRespose.data.toListEntity();

        final loading = [...state.isloading];
        final page = [...state.page];
        loading[event.index] = false;
        page[event.index] = page[event.index] + 1;
        //----------
        emit(state.copyWith(
          question: question,
          isloading: loading,
          page: page,
        ));
        debugPrint("after ===${page[event.index]}");
        if (state.page[event.index] > questionRespose.mate!.lastPage) {
          final isMore = [...state.isloading];
          isMore[event.index] = false;
          emit(state.copyWith(isMorePage: isMore));
        }
      },
      onError: (error) async {
        final loading = [...state.isloading];
        loading[event.index] = false;
        emit(state.copyWith(isloading: loading));
        debugPrint("get question error  $error");
      },
    );
    return null;
  }
}
