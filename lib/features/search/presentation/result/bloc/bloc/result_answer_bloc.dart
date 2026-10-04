import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../../data/models/profile/answer_model.dart';
import '../../../../domain/usecase/get_search_answer_usecase.dart';

import '../../../../../../app/base/bloc/bloc.dart';
import '../../../../../profile/domain/entities/answer_entity.dart';

part 'result_answer_event.dart';
part 'result_answer_state.dart';
part 'result_answer_bloc.freezed.dart';

@Injectable()
class ResultAnswerBloc extends BaseBloc<ResultAnswerEvent, ResultAnswerState> {
  final GetSearchAnswerUsecase _searchAnswerUsecase;
  ResultAnswerBloc(this._searchAnswerUsecase) : super(const _Initial()) {
    on<SearchAnswerEvent>(_searchAnswer);
    on<RefreshPage>(_refreshpage);
    on<ClickAnswer>(_clickAnswer);
    on<ClickAvatar>(_clickAvatar);

    on<RemoveIndex>(_removeIndex);
    on<RemoveAll>(_removeAll);
  }
  FutureOr<void> _searchAnswer(
      SearchAnswerEvent event, Emitter<ResultAnswerState> emit) async {
    final recentSearch = await loadProfiles();
    emit(state.copyWith(recentSearch: recentSearch));

    if (event.q.isNotEmpty) {
      await runAppCatching(
        () async {
          emit(state.copyWith(isLoaing: true));
          final answerRespose = await _searchAnswerUsecase
              .excecute(QPageInput(q: event.q, page: state.page));
          List<AnswertEntity> all = [...state.answer];
          all.addAll(answerRespose.data.toListEntity());
          emit(state.copyWith(
              answer: all, isLoaing: false, page: state.page + 1));
          if (state.page > answerRespose.mate!.lastPage) {
            emit(state.copyWith(isMorePage: false));
          }
        },
        onError: (error) async {
          emit(state.copyWith(isLoaing: false));
          debugPrint("catch get answr $error");
        },
      );
    }
  }

  FutureOr<void> _refreshpage(
      RefreshPage event, Emitter<ResultAnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isMorePage: true, page: 1));
        final answerRespose = await _searchAnswerUsecase
            .excecute(QPageInput(q: event.q, page: state.page));
        emit(state.copyWith(
            answer: answerRespose.data.toListEntity(),
            isLoaing: false,
            page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoaing: false));
        debugPrint("catch get answr $error");
      },
    );
  }

  FutureOr<void> _clickAnswer(
      ClickAnswer event, Emitter<ResultAnswerState> emit) {
    appRoute.push(AppRouteInfo.questionDetail(
        id: event.answer.question_id, answerId: event.answer.id));
    storeQuestion(event.answer);
  }

  FutureOr<void> _clickAvatar(
      ClickAvatar event, Emitter<ResultAnswerState> emit) {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  Future<void> storeQuestion(AnswertEntity question) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchAnswer);
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
      key: SharedPreferenceKeys.recentSearchAnswer,
      value: jsonEncode(jsonList),
    );
  }

  FutureOr<void> _removeIndex(
      RemoveIndex event, Emitter<ResultAnswerState> emit) {
    final recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    removeQuestionAtIndex(event.index);
  }

  FutureOr<void> _removeAll(
      RemoveAll event, Emitter<ResultAnswerState> emit) async {
    await LocalStorage.remove(SharedPreferenceKeys.recentSearchAnswer);
    emit(state.copyWith(recentSearch: []));
  }

  Future<List<AnswertEntity>> loadProfiles() async {
    try {
      final jsonString =
          LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchAnswer);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<AnswertEntity> answer =
          jsonList.map((e) => AnswertEntity.fromJson(e)).toList();
      debugPrint("recent answer  ${answer.length}");
      return answer;
    } catch (value) {
      debugPrint("errror $value");
      return [];
    }
  }

  Future<void> removeQuestionAtIndex(int index) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchAnswer);
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
        key: SharedPreferenceKeys.recentSearchAnswer,
        value: jsonEncode(jsonList),
      );
    }
  }
}
