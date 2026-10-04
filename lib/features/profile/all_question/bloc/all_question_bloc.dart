import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../../../../data/models/question_model.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/home_api_service.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../home/domain/usecase/get_all_questions_usecase.dart';
import '../../../home/domain/usecase/like_question_usecase.dart';
import '../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../security_login/domain/usecase/un_hide_usecase.dart';
import '../../domain/usecase/get_other_question_usecase.dart';

part 'all_question_event.dart';
part 'all_question_state.dart';
part 'all_question_bloc.freezed.dart';

@Injectable()
class AllQuestionBloc extends BaseBloc<AllQuestionEvent, AllQuestionState> {
  AllQuestionBloc(
    this._getAllQuestionUsecase,
    this._likeQuestionUseCase,
    this._unLikeQuestion,
    this._createHideUsercase,
    this._unHideUsecase,
    this._getOtherQuestionUseCase,
  ) : super(const AllQuestionState()) {
    on<ClickHideEvent>(_clickHide);
    on<ClickLikeEvent>(_clickLike);
    on<ClickQuestionEvent>(_clickQuestion);
    on<GetQuestionEvent>(_getQuestion);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickDoubleTapEvent>(_clickDoubleTap);
    on<RefreshPage>(_refreshPage);
    on<ClickShareQuestion>(_shareQuestion);
  }

  final GetAllQuestionUsecase _getAllQuestionUsecase;
  final GetOtherQuestionUseCase _getOtherQuestionUseCase;

  final LikeQuestionUseCase _likeQuestionUseCase;
  final UnLikeQuestion _unLikeQuestion;
  final CreateHideUsercase _createHideUsercase;
  final UnHideUsecase _unHideUsecase;
  FutureOr<void> _shareQuestion(
      ClickShareQuestion event, Emitter<AllQuestionState> emti) async {
    await shareQuestion(event.question);
  }

  FutureOr<void> _clickQuestion(
      ClickQuestionEvent event, Emitter<AllQuestionState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.questionEntity));
  }

  FutureOr<void> _clickLike(
      ClickLikeEvent event, Emitter<AllQuestionState> emit) async {
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
          await _unLikeQuestion.excecute(currentQuestion.id);
        }
      },
      onError: (error) async {
        debugPrint("you have on catch  $error");
      },
    );
  }

  FutureOr<void> _clickDoubleTap(
      ClickDoubleTapEvent event, Emitter<AllQuestionState> emit) async {
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

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<AllQuestionState> emit) async {
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
      ClickUnHideEvent event, Emitter<AllQuestionState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.questions];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: false);
        emit(state.copyWith(questions: question));
        await _unHideUsecase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _getQuestion(
      GetQuestionEvent event, Emitter<AllQuestionState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final QuestionResposeEntity questionResponse;
        if (event.userId == 0) {
          questionResponse = await _getAllQuestionUsecase.excecute(
            GetQuestionInput(
              page: state.page,
              // like: state.filter.like,
              // date: state.filter.date,
              // status: state.filter.status,
              // tags: state.filter.tag.map((tag) => tag.id).toList(),
            ),
          );
        } else {
          questionResponse = await _getOtherQuestionUseCase
              .excecute(UserIdPageInput(page: state.page, id: event.userId));
        }
        final all = [...state.questions];
        all.addAll(questionResponse.data.toListEntity());
        emit(state.copyWith(
            isLoading: false, questions: all, page: state.page + 1));
        if (state.page > questionResponse.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<AllQuestionState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final QuestionResposeEntity questionResponse;
        if (event.userId == 0) {
          questionResponse = await _getAllQuestionUsecase.excecute(
            GetQuestionInput(
              page: state.page,
              // like: state.filter.like,
              // date: state.filter.date,
              // status: state.filter.status,
              // tags: state.filter.tag.map((tag) => tag.id).toList()
            ),
          );
        } else {
          questionResponse = await _getOtherQuestionUseCase
              .excecute(UserIdPageInput(page: state.page, id: event.userId));
        }
        emit(state.copyWith(
            isLoading: false,
            questions: questionResponse.data.toListEntity(),
            page: state.page + 1));
        if (state.page > questionResponse.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
