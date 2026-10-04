import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../data/models/profile/answer_model.dart';
import '../../domain/entities/answer_respose_entity.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/data_sources/remotes/profile_api_service.dart';
import '../../domain/entities/answer_entity.dart';
import '../../domain/usecase/get_answer_by_user_usecase.dart';
import '../../domain/usecase/get_other_answer_usecase.dart';

part 'all_answer_event.dart';
part 'all_answer_state.dart';
part 'all_answer_bloc.freezed.dart';

@Injectable()
class AllAnswerBloc extends BaseBloc<AllAnswerEvent, AllAnswerState> {
  AllAnswerBloc(this._getAnswerByUserUserCase, this._getOtherAnswerUseCase)
      : super(const AllAnswerState()) {
    on<GetAnswerEvent>(_getAnswer);
    on<ClickAnswerEvent>(_clickAnswer);
    on<RefreshPage>(_refreshPage);
  }
  final GetAnswerByUserUserCase _getAnswerByUserUserCase;
  final GetOtherAnswerUseCase _getOtherAnswerUseCase;
  FutureOr<void> _clickAnswer(
      ClickAnswerEvent event, Emitter<AllAnswerState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(id: event.questionId));
  }

  FutureOr<void> _getAnswer(
      GetAnswerEvent event, Emitter<AllAnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        AnswerResposeEntity answerRespose;

        if (event.userId > 0) {
          answerRespose = await _getOtherAnswerUseCase
              .excecute(UserIdPageInput(page: state.page, id: event.userId));
        } else {
          answerRespose = await _getAnswerByUserUserCase.excecute(state.page);
        }
        final all = [...state.answer];
        all.addAll(answerRespose.data.toListEntity());
        emit(state.copyWith(
            answer: all, isLoading: false, page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<AllAnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        AnswerResposeEntity answerRespose;

        if (event.userId > 0) {
          answerRespose = await _getOtherAnswerUseCase
              .excecute(UserIdPageInput(page: state.page, id: event.userId));
        } else {
          answerRespose = await _getAnswerByUserUserCase.excecute(state.page);
        }
        emit(state.copyWith(
            answer: answerRespose.data.toListEntity(),
            isLoading: false,
            page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
