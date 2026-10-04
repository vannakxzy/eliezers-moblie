// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../data/data_sources/remotes/home_api_service.dart';
import '../../../../../data/models/filter_entity.dart';
import '../../../../../data/models/question_model.dart';
import '../../../../category/domain/usecase/delete_save_question.dart';
import '../../../../home/domain/entities/question_entity.dart';
import '../../../../home/domain/usecase/get_all_questions_usecase.dart';
import '../../../../home/domain/usecase/like_question_usecase.dart';
import '../../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../../security_login/domain/usecase/un_hide_usecase.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/usecase/cancel_request_band_usecase.dart';
import '../../../domain/usecase/delete_band_usecase.dart';
import '../../../domain/usecase/find_band_usecase.dart';
import '../../../domain/usecase/join_band_usecase.dart';
import '../../../domain/usecase/leave_from_band_usecase.dart';
import '../../../domain/usecase/request_to_join_band_usecase.dart';

part 'band_detail_event.dart';
part 'band_detail_state.dart';
part 'band_detail_bloc.freezed.dart';

@Injectable()
class bandDetailBloc extends BaseBloc<BandDetailEvent, bandDetailState> {
  bandDetailBloc(
      this._joinbandUsecase,
      this._leavebandUsecase,
      this._requestToJoinbandUsecase,
      this._getAllQuestionUsecase,
      this._findbandUsecase,
      this._createHideUsercase,
      this._unHideUsecase,
      this._deleteCommmunitUsecase,
      this._likeQuestionUseCase,
      this._deleteSaveQuestionUseCase,
      this._canRequestbandUsecase,
      this._unLikeQuestion)
      : super(_Initial()) {
    on<InitCommunitDetail>(_initPage);
    on<ClickLeaveCommunit>(_clickLeave);
    on<ClickJoin>(_clickJoinband);
    on<ClickRequest>(_clickRequest);
    on<ClickShare>(_shareQuestion);
    on<ClickCreateQuestion>(_clickCreateQuestion);
    on<ClickHideEvent>(_clickHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickLikeEvent>(_clickLike);
    on<DoubleTapEvent>(_clickDoubleTap);
    on<ClickQuestionEvetn>(_clickQuestion);
    on<RefreshPage>(_onRefreshpage);
    on<ClickSaveQuestion>(_clickSaveQuestion);
    on<ClickCreateDiscussion>(_clickCreateDiscussion);
    on<ClickOutsiteCreatePost>(_clickOutsitee);
    on<ClickPost>(_clickPost);
    on<ClickViembandinfo>(_clickSeebandInfo);
    on<ClickManageband>(_clickmanageband);
    on<ClickDeleteAndLeave>(_clickDeleteAndLeaveband);
    on<ApplyFilerEvent>(_applyFilter);
    on<ListionScroll>(_listionScroll);
    on<ClickCancelRequest>(_clickCancel);
  }
  final CancelRequestbandUsecase _canRequestbandUsecase;
  final JoinbandUsecase _joinbandUsecase;
  final LeavebandUsecase _leavebandUsecase;
  final RequestToJoinbandUsecase _requestToJoinbandUsecase;
  final GetAllQuestionUsecase _getAllQuestionUsecase;
  final CreateHideUsercase _createHideUsercase;
  final UnHideUsecase _unHideUsecase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final DeleteSaveQuestionUseCase _deleteSaveQuestionUseCase;
  final UnLikeQuestion _unLikeQuestion;
  final DeletebandUsecase _deleteCommmunitUsecase;
  final FindbandUsecase _findbandUsecase;

  FutureOr<void> _clickCancel(
      ClickCancelRequest event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(band: state.band.copyWith(status: 'active')));
        await _canRequestbandUsecase.excecute(event.bandId);
      },
    );
  }

  FutureOr<void> _initPage(
      InitCommunitDetail event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        debugPrint("ddddddddddddddddddddddddd");
        if (event.band != BandEntity()) {
          emit(state.copyWith(
            band: event.band,
          ));
        } else {
          emit(state.copyWith(loaingQuestion: true));
          final BandEntity = await _findbandUsecase.excecute(event.bandId);
          emit(state.copyWith(band: BandEntity));
        }
        final questionRepose =
            await _getAllQuestionUsecase.excecute(GetQuestionInput(
          band_id: event.bandId,
          page: state.page,
          date: state.filter.date,
          like: state.filter.like,
          status: state.filter.status,
          tags: state.filter.tag.map((item) => item.id).toList(),
          type: state.filter.type,
        ));
        List<QuestionEntity> all = [...state.questions];
        all.addAll(questionRepose.data.toListEntity());
        emit(state.copyWith(
            questions: all, loaingQuestion: false, page: state.page + 1));
        emit(state.copyWith(
            filter: state.filter.copyWith(band_id: event.band.id)));
        if (state.page > questionRepose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        debugPrint("you have on catch$error ");
        emit(state.copyWith(loaingQuestion: false));
      },
    );
  }

  FutureOr<void> _clickCreateQuestion(
      ClickCreateQuestion event, Emitter<bandDetailState> emit) async {
    appRoute.push(AppRouteInfo.createNewPost(event.band));
  }

  FutureOr<void> _applyFilter(
      ApplyFilerEvent event, Emitter<bandDetailState> emit) async {
    emit(state.copyWith(filter: event.filter));
    add(RefreshPage());
  }

  FutureOr<void> _listionScroll(
      ListionScroll event, Emitter<bandDetailState> emit) async {
    emit(state.copyWith(pi: event.pi));
  }

  FutureOr<void> _clickOutsitee(
      ClickOutsiteCreatePost event, Emitter<bandDetailState> emit) async {
    emit(state.copyWith(showPost: false));
  }

  FutureOr<void> _clickPost(
      ClickPost event, Emitter<bandDetailState> emit) async {
    emit(state.copyWith(showPost: !state.showPost));
  }

  FutureOr<void> _clickCreateDiscussion(
      ClickCreateDiscussion event, Emitter<bandDetailState> emit) async {
    appRoute.push(AppRouteInfo.postDiscussion(event.band));
  }

  FutureOr<void> _clickmanageband(
      ClickManageband event, Emitter<bandDetailState> emit) async {
    final band =
        await appRoute.push(AppRouteInfo.manageband(event.band)) as BandEntity;
    emit(state.copyWith(band: band));
  }

  FutureOr<void> _clickSeebandInfo(
      ClickViembandinfo event, Emitter<bandDetailState> emit) async {
    final BandEntity data =
        await appRoute.push(AppRouteInfo.bandInfo(event.band)) as BandEntity;
    emit(state.copyWith(band: data));
  }

  FutureOr<void> _clickJoinband(
      ClickJoin event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(band: state.band.copyWith(status: "active")));
        await _joinbandUsecase.excecute(state.band.id);
      },
    );
  }

  FutureOr<void> _shareQuestion(
      ClickShare event, Emitter<bandDetailState> emti) async {
    await shareband(state.band);
  }

  FutureOr<void> _clickLeave(
      ClickLeaveCommunit event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(band: state.band.copyWith(status: "")));
        await _leavebandUsecase.excecute(state.band.id);
        appRoute.pop(result: true);
      },
    );
  }

  FutureOr<void> _clickDeleteAndLeaveband(
      ClickDeleteAndLeave event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(band: state.band.copyWith(status: "")));
        await _deleteCommmunitUsecase.excecute(state.band.id);
        appRoute.pop(result: true);
      },
    );
  }

  FutureOr<void> _clickRequest(
      ClickRequest event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(band: state.band.copyWith(status: "pedding")));
        await _requestToJoinbandUsecase.excecute(state.band.id);
      },
    );
  }

  FutureOr<void> _clickSaveQuestion(
      ClickSaveQuestion event, Emitter<bandDetailState> emit) async {
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
      ClickQuestionEvetn event, Emitter<bandDetailState> emit) async {
    if (event.question.is_discussion) {
      appRoute
          .push(AppRouteInfo.discussionDetail(questionEntity: event.question));
    } else {
      appRoute.push(AppRouteInfo.questionDetail(
          id: event.id, questionEntity: event.question));
    }
  }

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<bandDetailState> emit) async {
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
      ClickUnHideEvent event, Emitter<bandDetailState> emit) async {
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
      DoubleTapEvent event, Emitter<bandDetailState> emit) async {
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
      ClickLikeEvent event, Emitter<bandDetailState> emit) async {
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
      RefreshPage event, Emitter<bandDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loaingQuestion: true, page: 1, isMorePage: true));
        final questionRepose =
            await _getAllQuestionUsecase.excecute(GetQuestionInput(
          band_id: state.band.id,
          page: state.page,
          date: state.filter.date,
          like: state.filter.like,
          status: state.filter.status,
          tags: state.filter.tag.map((item) => item.id).toList(),
          type: state.filter.type,
        ));
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
}
