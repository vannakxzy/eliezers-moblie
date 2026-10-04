// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../data/models/filter_entity.dart';
import '../../../../band/domain/entities/band_entity.dart';
import '../../../../band/domain/usecase/search__usecase.dart';
import '../../../../home/domain/entities/question_entity.dart';
import '../../../../post/domain/entities/tag_entity.dart';
import '../../../../profile/domain/entities/answer_entity.dart';
import '../../../../profile/domain/entities/profile_entity.dart';
import '../../../domain/usecase/get_result_search_usecase.dart';
import '../../../domain/usecase/get_search_answer_usecase.dart';
import '../../../domain/usecase/get_search_user_usecase.dart';
import '../../../domain/usecase/search_tag_count_usercase.dart';

part 'result_search_event.dart';
part 'result_search_state.dart';
part 'result_search_bloc.freezed.dart';

@Injectable()
class ResultSearchBloc extends BaseBloc<ResultSearchEvent, ResultSearchState> {
  ResultSearchBloc(
      this._searchAnswerUsecase,
      this._searchQuestionUsecase,
      this._searchbandUsecase,
      this._searchUserUsecase,
      this._searchTagCountUsercase)
      : super(const _Initial()) {
    on<ClickSearchEvent>(_clickSearch);
    on<TextSearchInputChanged>(_textSearchInputChange);
    on<ClearTextSearch>(_clearTextSearch);
    on<InitialEvent>(_onInitialEvent);
    on<ClickClearAllHistory>(_clickClearAllHistory);
    on<ClickRemoveHistoryItem>(_clickRemoveHistoryItem);
    on<ApplyFilerEvent>(_applyFilter);
  }
  final GetSearchAnswerUsecase _searchAnswerUsecase;
  final GetResultSearchUseCase _searchQuestionUsecase;
  final SearchbandUsecase _searchbandUsecase;
  final GetSearchUserUsecase _searchUserUsecase;
  final SearchTagCountUsercase _searchTagCountUsercase;

  FutureOr<void> _applyFilter(
      ApplyFilerEvent event, Emitter<ResultSearchState> emit) async {
    debugPrint("ddddddddddddddddddddd");
    emit(state.copyWith(filter: event.filter));
  }

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<ResultSearchState> emit) async {
    await runAppCatching(
      () async {
        final recentSearch =
            LocalStorage.getListString(SharedPreferenceKeys.recentSearch);
        emit(state.copyWith(
          recentSearch: recentSearch,
          textSearchController: TextEditingController(text: event.text),
          textSearch: event.text,
        ));
      },
      onError: (error) async {
        debugPrint("$error");
      },
    );
  }

  FutureOr<void> _clickSearch(
      ClickSearchEvent event, Emitter<ResultSearchState> emit) async {
    if (event.text.isEmpty) return;
    appRoute.push(AppRouteInfo.resultSearch(event.text, 0));
    _storeRecentSearches(emit);
  }

  FutureOr<void> _textSearchInputChange(
      TextSearchInputChanged event, Emitter<ResultSearchState> emit) {
    emit(state.copyWith(textSearch: event.value));
  }

  FutureOr<void> _clearTextSearch(
      ClearTextSearch event, Emitter<ResultSearchState> emit) {
    emit(state.copyWith(
        textSearch: '', textSearchController: TextEditingController()));
  }

  Future<void> _storeRecentSearches(Emitter<ResultSearchState> emit) async {
    List<String> re = [...state.recentSearch];
    re.remove(state.textSearch);
    re.insert(0, state.textSearch);
    emit(state.copyWith(recentSearch: re));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  FutureOr<void> _clickRemoveHistoryItem(
      ClickRemoveHistoryItem event, Emitter<ResultSearchState> emit) async {
    List<String> re = [...state.recentSearch];
    re.removeAt(event.index);
    emit(state.copyWith(recentSearch: re));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  FutureOr<void> _clickClearAllHistory(
      ClickClearAllHistory event, Emitter<ResultSearchState> emit) async {
    List<String> re = [...state.recentSearch];
    re.clear();
    emit(state.copyWith(recentSearch: re));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }
}
