// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../data/models/question_model.dart';
import '../../../../category/domain/entities/category_entity.dart';
import '../../../../security_login/domain/usecase/un_hide_by_questionId.dart';

import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../category/domain/usecase/delete_category_usecase.dart';
import '../../../../category/domain/usecase/delete_save_question.dart';
import '../../../../category/domain/usecase/get_category_usecase.dart';
import '../../../../category/domain/usecase/merge_cateogry_usecase.dart';
import '../../../../search/domain/usecase/get_result_search_usecase.dart';
import '../../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../domain/entities/question_entity.dart';
import '../../../domain/usecase/like_question_usecase.dart';
import '../../../domain/usecase/un_like_question_usecase.dart';

part 'all_book_event.dart';
part 'all_book_state.dart';
part 'all_book_bloc.freezed.dart';

@Injectable()
class AllBookBloc extends BaseBloc<AllBookEvent, AllBookState> {
  AllBookBloc(
      this._deleteCategoryUsecase,
      this._mergeCategoryUseCase,
      this._createHideUsercase,
      this._unLikeQuestion,
      this._likeQuestionUseCase,
      this._getCategoryEventUsecase,
      this._getResultSearchUseCase,
      this._deleteSaveQuestionUseCase,
      this._unHideUsecase)
      : super(const _Initial()) {
    on<ClickDoubleTanQuestionByCategory>(_clickDoubleTapQuestionBycategory);
    on<InitPage>(_initPage);
    on<ClickLikeQuestionByCategory>(_clickLikeQuestionbycategory);
    on<ClickHideQuestionByCategory>(_clickHideQuestionBycategory);
    on<GetQuestionEventd>(_getQuestionBycategory);
    on<ClickUnhideQuestion>(_clickUnHide);
    on<ClickSaveQuestiond>(_clickSaveQuestionbycategory);
    on<ClickQuestionEventd>(_clickQuestion);
    on<RefreshPaged>(_refreshPage);
    on<ClickShareQuestion>(_clickShareQuestion);
  }
  final DeleteCategoryUsecase _deleteCategoryUsecase;
  final MergeCategoryUseCase _mergeCategoryUseCase;
  final CreateHideUsercase _createHideUsercase;
  final UnLikeQuestion _unLikeQuestion;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;
  final UnHideByQuestionidUseCase _unHideUsecase;

  final LikeQuestionUseCase _likeQuestionUseCase;
  final GetCategoryEventUsecase _getCategoryEventUsecase;
  final GetResultSearchUseCase _getResultSearchUseCase;
  FutureOr<void> _clickQuestion(
      ClickQuestionEventd event, Emitter<AllBookState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.questionEntity));
  }

  FutureOr<void> _clickShareQuestion(
      ClickShareQuestion event, Emitter<AllBookState> emit) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _clickHideQuestionBycategory(
      ClickHideQuestionByCategory event, Emitter<AllBookState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> questions = state.questions
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = questions[event.categoryIndex][event.index];
        questions[event.categoryIndex][event.index] =
            currentQuestion.copyWith(isHide: !currentQuestion.isHide);
        emit(state.copyWith(questions: questions));
        await _createHideUsercase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _initPage(InitPage event, Emitter<AllBookState> emit) {
    try {
      List<bool> loading = List.filled(event.category.length, true);
      List<bool> isMorePage = List.filled(event.category.length, true);
      List<ScrollController> scr =
          List.generate(event.category.length, (index) => ScrollController());
      List<int> page = List.filled(event.category.length, 1);
      List<List<QuestionEntity>> questions =
          List.filled(event.category.length, []);
      emit(state.copyWith(
          isloading: loading,
          questions: questions,
          scrollController: scr,
          page: page,
          isMorePage: isMorePage));
      debugPrint("scr scrscr ${state.scrollController.length}");
    } catch (e) {
      debugPrint("initininin error $e");
    }
  }

  FutureOr<void> _getQuestionBycategory(
      GetQuestionEventd event, Emitter<AllBookState> emit) async {
    await runAppCatching(() async {
      final question = [...state.questions];
      final beloading = [...state.isloading];
      beloading[event.index] = true;
      emit(state.copyWith(isloading: beloading));
      final questionRespose = await _getResultSearchUseCase
          .excecute(QPageInput(q: event.q, page: state.page[event.index]));
      question[event.index].addAll(questionRespose.data.toListEntity());
      final loading = [...state.isloading];
      loading[event.index] = false;
      final page = [...state.page];
      page[event.index] = page[event.index] + 1;
      //----------
      emit(state.copyWith(
        questions: question,
        isloading: loading,
        page: page,
      ));
      if (state.page[event.index] > questionRespose.mate!.lastPage) {
        final isMore = [...state.isloading];
        isMore[event.index] = false;
        emit(state.copyWith(isMorePage: isMore));
      }
    }, onError: (value) async {
      final loading = [...state.isloading];
      loading[event.index] = false;
      emit(state.copyWith(isloading: loading));
      debugPrint("erororo $value");
    });
  }

  FutureOr<void> _refreshPage(
      RefreshPaged event, Emitter<AllBookState> emit) async {
    await runAppCatching(() async {
      final beforePage = [...state.page];
      final beforeLoading = [...state.isloading];
      final isMorePage = [...state.isMorePage];
      beforeLoading[event.index] = false;
      isMorePage[event.index] = true;
      beforePage[event.index] = 1;
      emit(state.copyWith(
          page: beforePage, isloading: beforeLoading, isMorePage: isMorePage));
      final questionRespose = await _getResultSearchUseCase
          .excecute(QPageInput(q: event.q, page: state.page[event.index]));
      final question = [...state.questions];
      final loading = [...state.isloading];
      final page = [...state.page];
      question[event.index] = questionRespose.data.toListEntity();
      loading[event.index] = false;
      page[event.index] = page[event.index] + 1;
      //----------
      emit(state.copyWith(
        questions: question,
        isloading: loading,
        page: page,
      ));
      if (state.page[event.index] > questionRespose.mate!.lastPage) {
        final isMore = [...state.isloading];
        isMore[event.index] = false;
        emit(state.copyWith(isMorePage: isMore));
      }
    }, onError: (value) async {
      final loading = [...state.isloading];
      loading[event.index] = false;
      emit(state.copyWith(isloading: loading));
      debugPrint("erororo $value");
    });
  }

  FutureOr<void> _clickUnHide(
      ClickUnhideQuestion event, Emitter<AllBookState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> questions = state.questions
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = questions[event.categoryIndex][event.index];
        questions[event.categoryIndex][event.index] =
            currentQuestion.copyWith(isHide: false);
        emit(state.copyWith(questions: questions));
        await _unHideUsecase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickDoubleTapQuestionBycategory(
      ClickDoubleTanQuestionByCategory event,
      Emitter<AllBookState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> questions = state.questions
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = questions[event.categoryIndex][event.index];
        final currentLike = currentQuestion.countLike;
        if (!currentQuestion.is_like) {
          questions[event.categoryIndex][event.index] = currentQuestion
              .copyWith(is_like: true, countLike: currentLike + 1);
          emit(state.copyWith(questions: questions));
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickSaveQuestionbycategory(
      ClickSaveQuestiond event, Emitter<AllBookState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> questions = state.questions
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = questions[event.categoryIndex][event.index];
        questions[event.categoryIndex][event.index] =
            currentQuestion.copyWith(is_saved: !currentQuestion.is_saved);
        emit(state.copyWith(questions: questions));
        if (currentQuestion.is_saved) {
          await _deleteSaveQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickLikeQuestionbycategory(
      ClickLikeQuestionByCategory event, Emitter<AllBookState> emit) async {
    await runAppCatching(
      () async {
        final List<List<QuestionEntity>> questions = state.questions
            .map((categoryQuestions) => [...categoryQuestions])
            .toList();
        final currentQuestion = questions[event.categoryIndex][event.index];
        final currentLike = currentQuestion.countLike;
        if (currentQuestion.is_like) {
          questions[event.categoryIndex][event.index] = currentQuestion
              .copyWith(is_like: false, countLike: currentLike - 1);
          emit(state.copyWith(questions: questions));
          await _unLikeQuestion.excecute(currentQuestion.id);
        } else {
          questions[event.categoryIndex][event.index] = currentQuestion
              .copyWith(is_like: true, countLike: currentLike + 1);
          emit(state.copyWith(questions: questions));
          await _likeQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }
}
