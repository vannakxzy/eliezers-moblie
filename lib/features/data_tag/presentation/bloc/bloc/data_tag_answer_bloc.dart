import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../data/data_sources/remotes/data_tag_api_service.dart';
import '../../../../../data/models/profile/answer_model.dart';
import '../../../../profile/domain/entities/answer_entity.dart';
import '../../../../profile/domain/entities/answer_respose_entity.dart';

import '../../../../../app/base/navigation/app_navigator.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../di/di.dart';
import '../../../domain/usecase/get_answer_user_tag_usecase.dart';
import '../../../domain/usecase/get_own_answer_by_tap_usecase.dart';

part 'data_tag_answer_event.dart';
part 'data_tag_answer_state.dart';
part 'data_tag_answer_bloc.freezed.dart';

@Injectable()
class DataTagAnswerBloc
    extends BaseBloc<DataTagAnswerEvent, DataTagAnswerState> {
  DataTagAnswerBloc(this._answerByUserUserCase, this._getownAnswerByTapUsecase)
      : super(const _Initial()) {
    on<DataTagAnswerEvent>((event, emit) {});
    on<InitPage>(_initPage);
    on<GetAnswer>(_getAnswer);
    on<RefreshPage>(_refreshPage);
    on<ClickAnswer>(_clickAnswer);
  }
  final GetAnserByUserByTagUseCase _answerByUserUserCase;
  final GetOwnAnswerByTapUsecase _getownAnswerByTapUsecase;

  FutureOr<void> _initPage(InitPage event, Emitter<DataTagAnswerState> emit) {
    List<bool> qtLoading = List.filled(event.tagLenght, true);
    List<bool> morepage = List.filled(event.tagLenght, true);
    List<int> page = List.filled(event.tagLenght, 1);
    List<List<AnswertEntity>> answer = List.filled(event.tagLenght, []);
    emit(state.copyWith(
        answer: answer,
        isloading: qtLoading,
        isMorePage: morepage,
        page: page));
    // add(GetAnswer(index: event.i, userId: userId, tagId: tagId))
    debugPrint(
        "ddddddddsadfdsafadsf${event.tagLenght} ${state.answer.length} ${state.isloading.length}");
  }

  FutureOr<void> _getAnswer(
      GetAnswer event, Emitter<DataTagAnswerState> emit) async {
    await runAppCatching(
      () async {
        final beforeLoaing = [...state.isloading];
        beforeLoaing[event.index] = true;
        emit(state.copyWith(isloading: beforeLoaing));
        AnswerResposeEntity answerRespose;
        if (event.userId > 0) {
          answerRespose = await _answerByUserUserCase.excecute(UserIdTagIdInput(
              tag_id: event.tagId,
              user_id: event.userId,
              page: state.page[event.index]));
        } else {
          answerRespose = await _getownAnswerByTapUsecase.excecute(
              TagIdInput(tag_id: event.tagId, page: state.page[event.index]));
        }
        final all = [...state.answer];
        all[event.index].addAll(answerRespose.data.toListEntity());
        final loading = [...state.isloading];
        final page = [...state.page];
        page[event.index] = page[event.index] + 1;
        loading[event.index] = false;
        emit(state.copyWith(
          isloading: loading,
          answer: all,
          page: page,
        ));
        if (state.page[event.index] > answerRespose.mate!.lastPage) {
          final isMore = [...state.isloading];
          isMore[event.index] = false;
          emit(state.copyWith(isMorePage: isMore));
        }
      },
      onError: (error) async {
        final loading = [...state.isloading];
        loading[event.index] = false;
        emit(state.copyWith(isloading: loading));
        debugPrint("get answer error  $error");
      },
    );
    return null;
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<DataTagAnswerState> emit) async {
    await runAppCatching(
      () async {
        final beforePage = [...state.page];
        final beforeLoading = [...state.isloading];
        final isMorePage = [...state.isMorePage];
        beforeLoading[event.index] = false;
        isMorePage[event.index] = true;
        beforePage[event.index] = 1;
        emit(state.copyWith(
            page: beforePage,
            isloading: beforeLoading,
            isMorePage: isMorePage));

        AnswerResposeEntity answerRespose;
        if (event.userId > 0) {
          answerRespose = await _answerByUserUserCase.excecute(UserIdTagIdInput(
              tag_id: event.tagId,
              user_id: event.userId,
              page: state.page[event.index]));
        } else {
          answerRespose = await _getownAnswerByTapUsecase.excecute(
              TagIdInput(tag_id: event.tagId, page: state.page[event.index]));
        }
        final all = [...state.answer];
        all[event.index] = answerRespose.data.toListEntity();
        final loading = [...state.isloading];
        final page = [...state.page];
        page[event.index] = page[event.index] + 1;
        loading[event.index] = false;
        emit(state.copyWith(
          isloading: loading,
          answer: all,
          page: page,
        ));
        if (state.page[event.index] > answerRespose.mate!.lastPage) {
          final isMore = [...state.isloading];
          isMore[event.index] = false;
          emit(state.copyWith(isMorePage: isMore));
        }
      },
      onError: (error) async {
        final loading = [...state.isloading];
        loading[event.index] = false;
        emit(state.copyWith(isloading: loading));
        debugPrint("get answer error  $error");
      },
    );
    return null;
  }
}

FutureOr<void> _clickAnswer(
    ClickAnswer event, Emitter<DataTagAnswerState> emit) {
  getIt.get<IAppNavigator>().push(AppRouteInfo.questionDetail(
      id: event.answer.question_id,
      questionEntity: null,
      answerId: event.answer.id));
}
