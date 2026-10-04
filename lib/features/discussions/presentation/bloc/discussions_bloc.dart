import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/home_api_service.dart';
import '../../../../data/models/filter_entity.dart';
import '../../../../data/models/question_model.dart';
import '../../../category/domain/usecase/delete_save_question.dart';
import '../../../band/domain/entities/band_entity.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../home/domain/usecase/get_all_questions_usecase.dart';
import '../../../home/domain/usecase/like_question_usecase.dart';
import '../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../security_login/domain/usecase/un_hide_by_questionId.dart';

part 'discussions_event.dart';
part 'discussions_state.dart';
part 'discussions_bloc.freezed.dart';

@Injectable()
class DiscussionsBloc extends BaseBloc<DiscussionsEvent, DiscussionsState> {
  final GetAllQuestionUsecase _getAllQuestionUsecase;
  final LikeQuestionUseCase _likeUseCase;
  final UnLikeQuestion _unLike;
  final CreateHideUsercase _createHideUsercase;
  final UnHideByQuestionidUseCase _unHideUsecase;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;

  DiscussionsBloc(
      this._getAllQuestionUsecase,
      this._likeUseCase,
      this._unLike,
      this._deleteSaveQuestionUseCase,
      this._unHideUsecase,
      this._createHideUsercase)
      : super(const _Initial()) {
    on<GetDiscussion>(_getDiscusstion);
    on<ClickLikeEvent>(_clickLike);
    on<ClickHideEvent>(_clickHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickSaveDiscussion>(_clickSaveDiscussion);
    on<ClickShare>(_clickShare);
    on<RefreshPage>(_refreshPage);
    on<ClickDiscussion>(_clickDiscussion);
    on<ApplyFilerEvent>(_applyFilter);
    on<ClickPostDiscussion>(_clickPostDiscussion);
  }
  FutureOr<void> _clickDiscussion(
      ClickDiscussion event, Emitter<DiscussionsState> emit) async {
    appRoute
        .push(AppRouteInfo.discussionDetail(questionEntity: event.discussion));
  }

  FutureOr<void> _clickPostDiscussion(
      ClickPostDiscussion event, Emitter<DiscussionsState> emit) async {
    appRoute.push(AppRouteInfo.postDiscussion(BandEntity()));
  }

  FutureOr<void> _applyFilter(
      ApplyFilerEvent event, Emitter<DiscussionsState> emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final questions =
            await _getAllQuestionUsecase.excecute(GetQuestionInput());
        emit(state.copyWith(
          isLoading: false,
          discussion: questions.data.toListEntity(),
          page: state.page + 1,
        ));
        if (state.page > questions.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        debugPrint("error get question $error");
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _clickSaveDiscussion(
      ClickSaveDiscussion event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> questions = [...state.discussion];
        final currentQuestion = questions[event.index];
        questions[event.index] =
            currentQuestion.copyWith(is_saved: !currentQuestion.is_saved);
        emit(state.copyWith(discussion: questions));
        if (currentQuestion.is_saved == true) {
          await _deleteSaveQuestionUseCase.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickUnHide(
      ClickUnHideEvent event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        final discussion = [...state.discussion];
        QuestionEntity currentdiscussion = discussion[event.index];
        discussion[event.index] = currentdiscussion.copyWith(isHide: false);
        emit(state.copyWith(discussion: discussion));
        await _unHideUsecase.excecute(currentdiscussion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        final discussion = [...state.discussion];
        QuestionEntity currentdiscussion = discussion[event.index];
        if (currentdiscussion.isHide) {}
        discussion[event.index] = currentdiscussion.copyWith(isHide: true);
        emit(state.copyWith(discussion: discussion));
        await _createHideUsercase.excecute(currentdiscussion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickShare(
      ClickShare event, Emitter<DiscussionsState> emit) async {
    await shareQuestion(event.discusstion);
  }

  FutureOr<void> _clickLike(
      ClickLikeEvent event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        List<QuestionEntity> discussion = [...state.discussion];
        final currentQuestion = discussion[event.index];
        final currentLikes = currentQuestion.countLike;
        if (currentQuestion.is_like == false) {
          discussion[event.index] = currentQuestion.copyWith(
              is_like: true, countLike: currentLikes + 1);
          emit(state.copyWith(discussion: discussion));
          await _likeUseCase.excecute(currentQuestion.id);
        } else {
          discussion[event.index] = currentQuestion.copyWith(
              countLike: currentLikes - 1, is_like: false);
          emit(state.copyWith(discussion: discussion));
          await _unLike.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _getDiscusstion(
      GetDiscussion event, Emitter<DiscussionsState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final discussion =
            await _getAllQuestionUsecase.excecute(GetQuestionInput());
        List<QuestionEntity> all = [...state.discussion];
        List<QuestionEntity> questionData = discussion.data.toListEntity();
        all.addAll(questionData);
        emit(state.copyWith(
            isLoading: false, discussion: all, page: state.page + 1));
        if (state.page > discussion.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        debugPrint("error get discussion $error");
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
