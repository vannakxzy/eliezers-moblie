import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../../data/models/band/band_model.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/usecase/get_band_usecase.dart';

part 'search_band_event.dart';
part 'search_band_state.dart';
part 'search_band_bloc.freezed.dart';

@Injectable()
class SearchbandBloc extends BaseBloc<SearchbandEvent, SearchBandState> {
  SearchbandBloc(this._getbandUsecase) : super(_Initial()) {
    on<InitialEvent>(_onInitial);
    on<ClickSearchEvent>(_clickSearchEvent);
    on<TextSearchChanged>(_textSearchInputChanged);
    on<ClickHistoryItem>(_clickHistoryItem);
    on<ClickRemoveHistoryItem>(_onClickRemoveHistoryItem);
    on<RefreshPage>(_refreshPage);
    on<ClickRemoveAllHistory>(_removeAllHistory);
  }
  final GetbandUsecase _getbandUsecase;
  FutureOr<void> _onInitial(
      InitialEvent event, Emitter<SearchBandState> emit) async {
    await runAppCatching(
      () async {
        final recentSearch =
            LocalStorage.getListString(SharedPreferenceKeys.recentSearch);
        emit(state.copyWith(recentSearch: recentSearch));
        emit(state.copyWith(isLoading: true));
        final response = await _getbandUsecase.excecute(GetbandInput(q: ''));
        emit(state.copyWith(
            isLoading: false,
            band: response.data.toListEntity(),
            page: state.page + 1));
        emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("$error");
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<SearchBandState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _getbandUsecase.excecute(GetbandInput(q: ''));
        emit(state.copyWith(
          isLoading: false,
          band: response.data.toListEntity(),
          page: state.page + 1,
        ));
        emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("$error");
      },
    );
  }

  FutureOr<void> _textSearchInputChanged(
      TextSearchChanged event, Emitter<SearchBandState> emit) async {
    emit(state.copyWith(searchText: event.value));
  }

  FutureOr<void> _clickHistoryItem(
      ClickHistoryItem event, Emitter<SearchBandState> emit) {
    emit(state.copyWith(searchText: event.text));
    add(const ClickSearchEvent());
  }

  // FutureOr<void> _onClickMostSearchItem(
  //     ClickMostSearchItem event, Emitter<SearchBandState> emit) {
  //   emit(state.copyWith(searchText: event.text));
  //   add(const ClickSearchEvent());
  // }

  FutureOr<void> _onClickRemoveHistoryItem(
      ClickRemoveHistoryItem event, Emitter<SearchBandState> emit) async {
    List<String> recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  Future<void> _storerecentSearches(Emitter<SearchBandState> emit) async {
    List<String> re = [...state.recentSearch];
    re.remove(state.searchText);
    re.insert(0, state.searchText);
    emit(state.copyWith(recentSearch: re));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: state.recentSearch,
    );
  }

  Future<void> _removeAllHistory(
      ClickRemoveAllHistory event, Emitter<SearchBandState> emit) async {
    emit(state.copyWith(recentSearch: []));
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearch,
      value: [],
    );
  }

  FutureOr<void> _clickSearchEvent(
      ClickSearchEvent event, Emitter<SearchBandState> emit) async {
    if (state.searchText.isEmpty) return;
    appRoute.push(AppRouteInfo.resultSearchband(state.searchText));
    _storerecentSearches(emit);
  }
}
