// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../domain/entities/popular_search_entity.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../domain/usecase/get_idea_usercaes.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

@Injectable()
class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  SearchBloc(
    this._getpopularSearchUseCase,
  ) : super(const SearchState()) {
    on<InitialEvent>(_onInitialEvent);
    on<TextSearchInputChanged>(_onTextSearchInputChanged);
    on<ClickSearchEvent>(_onClickSearchEvent);
    on<ClickHistoryItem>(_onClickHistoryItem);
    on<ClickRemoveHistoryItem>(_onClickRemoveHistoryItem);
    on<ClickMostSearchItem>(_onClickMostSearchItem);
    on<ClickShowMoreOrLess>(_onClickShowMoreOrLess);
    on<ClearTextSearchInput>(_onClearTextSearchInput);
  }
  final GetpopularSearchUseCase _getpopularSearchUseCase;

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<SearchState> emit) async {
    await runAppCatching(
      () async {
        final recentSearch =
            LocalStorage.getListString(SharedPreferenceKeys.recentSearch);
        emit(state.copyWith(recentSearch: recentSearch));
        emit(state.copyWith(isloading: true));
        final popular = await _getpopularSearchUseCase.excecute('');
        emit(state.copyWith(isloading: false, popularSearch: popular));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
        debugPrint("$error");
      },
    );

    // get recent Search
  }

  FutureOr<void> _onTextSearchInputChanged(
      TextSearchInputChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      searchText: event.textSearch ?? '',
    ));
  }

  FutureOr<void> _onClickHistoryItem(
      ClickHistoryItem event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchText: event.text));
    add(const ClickSearchEvent());
  }

  FutureOr<void> _onClickMostSearchItem(
      ClickMostSearchItem event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchText: event.text));
    add(const ClickSearchEvent());
  }

  FutureOr<void> _onClickRemoveHistoryItem(
      ClickRemoveHistoryItem event, Emitter<SearchState> emit) async {
    List<String> recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  Future<void> _storeRecentSearches(Emitter<SearchState> emit) async {
    List<String> re = [...state.recentSearch];
    re.remove(state.searchText);
    re.insert(0, state.searchText);
    emit(state.copyWith(recentSearch: re));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  FutureOr<void> _onClickSearchEvent(
      ClickSearchEvent event, Emitter<SearchState> emit) async {
    if (state.searchText.isEmpty) return;
    appRoute.push(AppRouteInfo.resultSearch(state.searchText, 0));

    _storeRecentSearches(emit);
  }

  FutureOr<void> _onClickShowMoreOrLess(
      ClickShowMoreOrLess event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        showAllHistories: !state.showAllHistories,
      ),
    );
  }

  FutureOr<void> _onClearTextSearchInput(
      ClearTextSearchInput event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchText: ''));
  }
}
