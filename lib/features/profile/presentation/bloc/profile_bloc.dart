// ignore_for_file: unused_field, void_checks

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../../../../data/models/profile/answer_model.dart';
import '../../../../data/models/question_model.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../../domain/entities/answer_respose_entity.dart';
import '../../domain/usecase/get_other_answer_usecase.dart';
import '../../domain/usecase/get_other_profile_usecase.dart';
import '../../domain/usecase/get_other_question_usecase.dart';
import '../../domain/usecase/get_other_setting_usecase.dart';
import '../../domain/usecase/get_other_top_tag_usecase.dart';
import '../../../security_login/domain/usecase/create_block_usercase.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../home/domain/usecase/like_question_usecase.dart';
import '../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../../search/domain/usecase/get_result_search_usecase.dart';
import '../../../security_login/domain/usecase/create_hide_usercase.dart';
import '../../../security_login/domain/usecase/un_hide_usecase.dart';
import '../../../setting/domain/entities/setting_entity.dart';
import '../../domain/entities/answer_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/top_tag_entity.dart';
import '../../domain/usecase/get_answer_by_user_usecase.dart';
import '../../domain/usecase/get_profile_usecase.dart';
import '../../domain/usecase/get_question_usercase.dart';
import '../../domain/usecase/get_top_tag_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getOtherAnswerUseCase,
    this._getOtherProfileUseCase,
    this._getOtherQuestionUseCase,
    this._getOtherSettingusecase,
    this._getOtherTopTagUseCase,
    this._blockUseCase,
    this._getProfileUsecase,
    this._getQuestionByUserUseCase,
    this._getAnswerByUserUserCase,
    this._getTopTagUseCase,
    this._getResultSearchUseCase,
    this._createHideUsercase,
    this._unHideUsecase,
    this._likeQuestionUseCase,
    this._unLikeQuestion,
  ) : super(const _Initial()) {
    on<GetAnswerEvent>(_getAnswer);
    on<GetQuestionEvent>(_getQuestion);
    on<GetProfileEvent>(_getProfile);
    on<GetSettingEvent>(_getSetting);
    on<GetTopTagEvent>(_getTopTag);
    on<ClickBlockEvent>(_clickBlock);
    on<ClickSettingEvent>(_clickSetting);
    on<ClickSeeAllQuestionEvent>(_clickAllQuestion);
    on<ClickSeeAllAnswerEvent>(_clickAllAnswer);
    on<ClickAnswerEvent>(_clickAnasser);
    on<ClickHideEvent>(_clickHide);
    on<ClickUnHideEvent>(_clickUnHide);
    on<ClickLikeEvent>(_clickLike);
    on<DoubleTapEvent>(_clickDoubleTap);
    on<ClickQuestionEvetn>(_clickQuestion);
    on<InitPageEvent>(_initpage);
    on<ClickShareUser>(_clickShareUser);
  }
  final GetOtherAnswerUseCase _getOtherAnswerUseCase;
  final GetOtherProfileUseCase _getOtherProfileUseCase;
  final GetOtherQuestionUseCase _getOtherQuestionUseCase;
  final GetOtherSettingusecase _getOtherSettingusecase;
  final GetOtherTopTagUseCase _getOtherTopTagUseCase;
  final GetProfileUsecase _getProfileUsecase;
  final GetQuestionByUserUseCase _getQuestionByUserUseCase;
  final GetAnswerByUserUserCase _getAnswerByUserUserCase;
  final GetTopTagUseCase _getTopTagUseCase;
  final CreateBlockUseCase _blockUseCase;
  final GetResultSearchUseCase _getResultSearchUseCase;
  final CreateHideUsercase _createHideUsercase;
  final UnHideUsecase _unHideUsecase;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final UnLikeQuestion _unLikeQuestion;
  FutureOr<void> _clickSetting(
      ClickSettingEvent event, Emitter<ProfileState> emit) {
    appRoute.push(const AppRouteInfo.setting());
  }

  FutureOr<void> _clickShareUser(
      ClickShareUser event, Emitter<ProfileState> emit) async {
    await shareUser(state.profileEntity);
  }

  FutureOr<void> _clickAllQuestion(
      ClickSeeAllQuestionEvent event, Emitter<ProfileState> emit) {
    appRoute.push(AppRouteInfo.allQuestion(event.userId));
  }

  FutureOr<void> _clickAnasser(
      ClickAnswerEvent event, Emitter<ProfileState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.answer.question_id,
        questionEntity: null,
        answerId: event.answer.id));
  }

  FutureOr<void> _clickAllAnswer(
      ClickSeeAllAnswerEvent event, Emitter<ProfileState> emit) {
    appRoute.push(AppRouteInfo.allAnswer(event.userId));
  }

  FutureOr<void> _clickBlock(
      ClickBlockEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(
      () async {
        appRoute.showInfoSnackBar(
          'User have been blocked successfully',
        );
        await _blockUseCase.excecute(event.userId);
      },
    );
  }

  FutureOr<void> _checkIsNothing(Emitter<ProfileState> emit) async {
    if (state.loadingGetToptag == false &&
        state.loadingQuestion == false &&
        state.loadingAnswer == false &&
        state.toptag.isEmpty &&
        state.answer.isEmpty &&
        state.question.isEmpty) {
      emit(state.copyWith(isNothing: true));
    } else {
      emit(state.copyWith(isNothing: false));
    }
  }

  FutureOr<void> _getTopTag(
      GetTopTagEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loadingGetToptag: true));
        List<TopTagEntity> toptag = [];
        if (event.userId > 0) {
          toptag = await _getOtherTopTagUseCase.excecute(event.userId);
        } else {
          toptag = await _getTopTagUseCase.excecute('');
        }
        emit(state.copyWith(toptag: toptag, loadingGetToptag: false));
        _checkIsNothing(emit);
      },
      onError: (error) async {
        emit(state.copyWith(loadingGetToptag: false));
        debugPrint("get top tag got error $error");
      },
    );
  }

  FutureOr<void> _initpage(
      InitPageEvent event, Emitter<ProfileState> emit) async {
    if (event.userId > 0) {
      await runAppCatching(() async {
        /// get setting
        // emit(state.copyWith(loadingSetting: true));
        // final setting = await _getOtherSettingusecase.excecute(event.userId);
        // emit(state.copyWith(setting: setting, loadingSetting: false));

        /// get profile
        emit(state.copyWith(getProfileLoading: true));
        final profile = await _getOtherProfileUseCase.excecute(event.userId);
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
        //-----------than------------------
        // if (!state.setting!.private_account || state.profileEntity.isYour) {
        //   add(GetTopTagEvent(event.userId));
        //   if (state.setting!.show_answer) {
        //     add(GetAnswerEvent(event.userId));
        //   }
        //   if (state.setting!.show_question) {
        //     add(GetQuestionEvent(event.userId));
        //   }
        // }
      });
    } else {
      await runAppCatching(() async {
        emit(state.copyWith(getProfileLoading: true));
        final profile = await _getProfileUsecase.excecute('');
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
        // add(GetTopTagEvent(event.userId));
        // add(GetAnswerEvent(event.userId));
        // add(GetQuestionEvent(event.userId));
      }, onError: (error) async {
        emit(state.copyWith(getProfileLoading: false));
        debugPrint("error $error");
      });
    }
  }

  FutureOr<void> _getSetting(
      GetSettingEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(loadingSetting: true));
      final setting = await _getOtherSettingusecase.excecute(event.userId);
      emit(state.copyWith(setting: setting, loadingSetting: false));
    });
  }

  FutureOr<void> _getAnswer(
      GetAnswerEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loadingAnswer: true));
        AnswerResposeEntity answerRespose;
        if (event.userId > 0) {
          answerRespose = await _getOtherAnswerUseCase
              .excecute(UserIdPageInput(page: 1, id: event.userId));
        } else {
          answerRespose = await _getAnswerByUserUserCase.excecute(1);
        }
        emit(state.copyWith(
            answer: answerRespose.data.toListEntity(), loadingAnswer: false));
        _checkIsNothing(emit);
      },
      onError: (error) async {
        emit(state.copyWith(loadingAnswer: false));
      },
    );
  }

  FutureOr<void> _getProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(getProfileLoading: true));
      if (event.userId > 0) {
        final profile = await _getOtherProfileUseCase.excecute(event.userId);
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
      } else {
        final profile = await _getProfileUsecase.excecute('');
        emit(state.copyWith(profileEntity: profile, getProfileLoading: false));
      }
    }, onError: (error) async {
      emit(state.copyWith(getProfileLoading: false));
      debugPrint("error $error");
    });
  }

  FutureOr<void> _getQuestion(
      GetQuestionEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(loadingQuestion: true));
      QuestionResposeEntity question;
      if (event.userId > 0) {
        question = await _getOtherQuestionUseCase
            .excecute(UserIdPageInput(page: 1, id: event.userId));
      } else {
        question = await _getQuestionByUserUseCase.excecute(1);
      }
      emit(state.copyWith(
          question: question.data.toListEntity(), loadingQuestion: false));
      _checkIsNothing(emit);
    }, onError: (eroor) async {
      debugPrint("catchddddd $eroor");
      emit(state.copyWith(loadingQuestion: false));
    });
  }

  FutureOr<void> _clickQuestion(
      ClickQuestionEvetn event, Emitter<ProfileState> emit) async {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.id, questionEntity: event.question));
  }

  FutureOr<void> _clickHide(
      ClickHideEvent event, Emitter<ProfileState> emit) async {
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
      ClickUnHideEvent event, Emitter<ProfileState> emit) async {
    await runAppCatching(
      () async {
        final question = [...state.question];
        final currentQuestion = question[event.index];
        question[event.index] = currentQuestion.copyWith(isHide: false);
        // question.removeAt(event.index);
        emit(state.copyWith(question: question));
        await _unHideUsecase.excecute(currentQuestion.id);
      },
      onError: (error) async {
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickDoubleTap(
      DoubleTapEvent event, Emitter<ProfileState> emit) async {
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
      ClickLikeEvent event, Emitter<ProfileState> emit) async {
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
