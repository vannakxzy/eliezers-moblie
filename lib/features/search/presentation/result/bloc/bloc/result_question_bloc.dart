import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../../app/base/bloc/base_event.dart';
import '../../../../../../app/base/bloc/base_state.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/helper/fuction.dart';
import '../../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../../data/models/question_model.dart';
import '../../../../../security_login/domain/usecase/un_hide_usecase.dart';

import '../../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../category/domain/usecase/delete_save_question.dart';
import '../../../../../home/domain/entities/question_entity.dart';
import '../../../../../home/domain/usecase/like_question_usecase.dart';
import '../../../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../../domain/usecase/get_result_search_usecase.dart';

part 'result_question_event.dart';
part 'result_question_state.dart';
part 'result_question_bloc.freezed.dart';

@Injectable()
class ResultQuestionBloc
    extends BaseBloc<ResultQuestionEvent, ResultQuestionState> {
  ResultQuestionBloc(
      this._getResultSearchUseCase,
      this._createHideUsercase,
      this._unHideUsecase,
      this._likeQuestionUseCase,
      this._unLikeQuestion,
      this._deleteSaveQuestionUseCase)
      : super(_Initial()) {
    on<SearchQuestionEvent>(_getResultSearch);
    on<ClickHideEvent>(_clickHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickLikeEvent>(_clickLike);
    on<DoubleTapEvent>(_clickDoubleTap);
    on<ClickQuestionEvetn>(_clickQuestion);
    on<OnRefreshPageEvent>(_onRefreshpage);
    on<ClickSaveQuestion>(_clickSaveQuestion);
    on<ClickShareQuestion>(_clickShareQuestion);

    on<RemoveIndex>(_removeIndex);
    on<RemoveAll>(_removeAll);
  }
  final GetResultSearchUseCase _getResultSearchUseCase;
  final CreateHideUsercase _createHideUsercase;
  final UnHideUsecase _unHideUsecase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;

  final UnLikeQuestion _unLikeQuestion;

  FutureOr<void> _clickShareQuestion(
      ClickShareQuestion event, Emitter<ResultQuestionState> emit) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _getResultSearch(
      SearchQuestionEvent event, Emitter<ResultQuestionState> emit) async {
    final recentSearch = await loadProfiles();
    emit(state.copyWith(recentSearch: recentSearch));
    if (event.text.isNotEmpty) {
      await runAppCatching(() async {
        try {
          emit(state.copyWith(loaingQuestion: true));
          final questionRepose = await _getResultSearchUseCase
              .excecute(QPageInput(q: event.text, page: state.page));
          List<QuestionEntity> all = [...state.questions];
          all.addAll(questionRepose.data.toListEntity());
          emit(state.copyWith(
              questions: all, loaingQuestion: false, page: state.page + 1));
          if (state.page > questionRepose.mate!.lastPage) {
            emit(state.copyWith(isMorePage: false));
          }
        } catch (e) {
          debugPrint("you have on catch$e ");
          emit(state.copyWith(loaingQuestion: false));
        }
      });
    }
  }

  FutureOr<void> _clickSaveQuestion(
      ClickSaveQuestion event, Emitter<ResultQuestionState> emit) async {
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
  }

  FutureOr<void> _clickQuestion(
      ClickQuestionEvetn event, Emitter<ResultQuestionState> emit) async {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.question));
    storQuestion(event.question);
  }

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<ResultQuestionState> emit) async {
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
  }

  FutureOr<void> _clickUnHide(
      ClickUnHideEvent event, Emitter<ResultQuestionState> emit) async {
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
  }

  FutureOr<void> _clickDoubleTap(
      DoubleTapEvent event, Emitter<ResultQuestionState> emit) async {
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
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _clickLike(
      ClickLikeEvent event, Emitter<ResultQuestionState> emit) async {
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
  }

  FutureOr<void> _onRefreshpage(
      OnRefreshPageEvent event, Emitter<ResultQuestionState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loaingQuestion: true, page: 1, isMorePage: true));
        final questionRepose = await _getResultSearchUseCase
            .excecute(QPageInput(q: event.text, page: state.page));
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
  }

  Future<void> storQuestion(QuestionEntity question) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchQuestion);
    List<dynamic> jsonList = [];
    if (jsonString.isNotEmpty) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        jsonList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        jsonList = [decoded];
      }
    }
    jsonList.removeWhere((e) => e['id'] == question.id);
    jsonList.insert(0, question.toJson());
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearchQuestion,
      value: jsonEncode(jsonList),
    );
  }

  FutureOr<void> _removeIndex(
      RemoveIndex event, Emitter<ResultQuestionState> emit) {
    final recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    removeQuestionAtIndex(event.index);
  }

  FutureOr<void> _removeAll(
      RemoveAll event, Emitter<ResultQuestionState> emit) async {
    await LocalStorage.remove(SharedPreferenceKeys.recentSearchQuestion);
    emit(state.copyWith(recentSearch: []));
  }

  Future<List<QuestionEntity>> loadProfiles() async {
    try {
      final jsonString = LocalStorage.getStringValue(
          SharedPreferenceKeys.recentSearchQuestion);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<QuestionEntity> question =
          jsonList.map((e) => QuestionEntity.fromJson(e)).toList();
      debugPrint("recent question  ${question.length}");
      return question;
    } catch (value) {
      debugPrint("errror $value");
      return [];
    }
  }

  Future<void> removeQuestionAtIndex(int index) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchQuestion);
    if (jsonString.isEmpty) return;
    final decoded = jsonDecode(jsonString);
    List<dynamic> jsonList = [];

    if (decoded is List) {
      jsonList = decoded;
    } else if (decoded is Map<String, dynamic>) {
      jsonList = [decoded];
    }

    if (index >= 0 && index < jsonList.length) {
      jsonList.removeAt(index);

      await LocalStorage.storeData(
        key: SharedPreferenceKeys.recentSearchQuestion,
        value: jsonEncode(jsonList),
      );
    }
  }
}
