import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../../app/base/bloc/base_event.dart';
import '../../../../../../app/base/bloc/base_state.dart';
import '../../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../../../data/models/band/band_model.dart';
import '../../../../../band/domain/entities/band_entity.dart';
import '../../../../../band/domain/usecase/cancel_request_band_usecase.dart';
import '../../../../../band/domain/usecase/join_band_usecase.dart';
import '../../../../../band/domain/usecase/leave_from_band_usecase.dart';
import '../../../../../band/domain/usecase/request_to_join_band_usecase.dart';
import '../../../../../band/domain/usecase/search__usecase.dart';

part 'result_band_event.dart';
part 'result_band_state.dart';
part 'result_band_bloc.freezed.dart';

@Injectable()
class ResultbandBloc extends BaseBloc<ResultbandEvent, ResultBandState> {
  ResultbandBloc(
      this._searchbandUsecase,
      this._joinbandUsecase,
      this._leavebandUsecase,
      this._requestToJoinbandUsecase,
      this._canRequestbandUsecase)
      : super(_Initial()) {
    on<InitPage>(_initPage);
    on<RefreshPage>(_refeschPage);
    on<Clickband>(_clickband);
    on<ClickLeave>(_clickLeave);
    on<ClickJoin>(_clickJoinband);
    on<ClickRequest>(_clickRequest);
    on<RemoveIndex>(_removeIndex);
    on<RemoveAll>(_removeAll);
    on<ClickCancelRequest>(_clickCancel);
  }
  final SearchbandUsecase _searchbandUsecase;
  final JoinbandUsecase _joinbandUsecase;
  final CancelRequestbandUsecase _canRequestbandUsecase;
  final LeavebandUsecase _leavebandUsecase;
  final RequestToJoinbandUsecase _requestToJoinbandUsecase;
  FutureOr<void> _clickJoinband(
      ClickJoin event, Emitter<ResultBandState> emit) async {
    List<BandEntity> band = [...state.band];
    await runAppCatching(
      () async {
        final currentCommunit = band[event.index];
        band[event.index] = currentCommunit.copyWith(
            status: "active", member: currentCommunit.member + 1);
        emit(state.copyWith(band: band));
        await _joinbandUsecase.excecute(currentCommunit.id);
      },
    );
  }

  FutureOr<void> _clickLeave(
      ClickLeave event, Emitter<ResultBandState> emit) async {
    List<BandEntity> band = [...state.band];

    await runAppCatching(
      () async {
        final currentCommunit = band[event.index];
        band[event.index] = currentCommunit.copyWith(
            status: "", member: currentCommunit.member - 1);
        emit(state.copyWith(band: band));
        await _leavebandUsecase.excecute(currentCommunit.id);
      },
    );
  }

  FutureOr<void> _clickCancel(
      ClickCancelRequest event, Emitter<ResultBandState> emit) async {
    List<BandEntity> band = [...state.band];

    await runAppCatching(
      () async {
        final currentCommunit = band[event.index];
        band[event.index] = currentCommunit.copyWith(status: "");
        emit(state.copyWith(band: band));
        await _canRequestbandUsecase.excecute(currentCommunit.id);
      },
    );
  }

  FutureOr<void> _clickRequest(
      ClickRequest event, Emitter<ResultBandState> emit) async {
    List<BandEntity> band = [...state.band];
    await runAppCatching(
      () async {
        final currentCommunit = band[event.index];
        band[event.index] = currentCommunit.copyWith(status: "pendding");
        emit(state.copyWith(band: band));
        await _requestToJoinbandUsecase.excecute(currentCommunit.id);
      },
    );
  }

  FutureOr<void> _refeschPage(
      RefreshPage event, Emitter<ResultBandState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _searchbandUsecase
            .excecute(SearchInput(q: event.text, page: state.page));
        emit(state.copyWith(
            isLoading: false,
            band: response.data.toListEntity(),
            page: state.page + 1));
        emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
        emit(state.copyWith(isMorePage: false));
      },
    );
  }

  FutureOr<void> _clickband(
      Clickband event, Emitter<ResultBandState> emit) async {
    appRoute.push(AppRouteInfo.bandDetail(event.band, event.band.id));
    storeDisscuss(event.band);
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<ResultBandState> emit) async {
    final recentSearch = await loadCommunitt();
    emit(state.copyWith(recentSearch: recentSearch));

    if (event.text.isNotEmpty) {
      await runAppCatching(
        () async {
          emit(state.copyWith(isLoading: true));
          final response = await _searchbandUsecase
              .excecute(SearchInput(q: event.text, page: state.page));
          List<BandEntity> all = [...state.band];
          all.addAll(response.data.toListEntity());
          emit(state.copyWith(
              isLoading: false, band: all, page: state.page + 1));
          emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
        },
        onError: (error) async {
          emit(state.copyWith(isLoading: false));
          debugPrint("you have been on catch $error");
        },
      );
    }
  }

  Future<void> storeDisscuss(BandEntity band) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchband);
    List<dynamic> jsonList = [];
    if (jsonString.isNotEmpty) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        jsonList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        jsonList = [decoded];
      }
    }
    jsonList.removeWhere((e) => e['id'] == band.id);
    jsonList.insert(0, band.toJson());
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearchband,
      value: jsonEncode(jsonList),
    );
  }

  FutureOr<void> _removeIndex(
      RemoveIndex event, Emitter<ResultBandState> emit) {
    final recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    removeQuestionAtIndex(event.index);
  }

  FutureOr<void> _removeAll(
      RemoveAll event, Emitter<ResultBandState> emit) async {
    await LocalStorage.remove(SharedPreferenceKeys.recentSearchband);
    emit(state.copyWith(recentSearch: []));
  }

  Future<List<BandEntity>> loadCommunitt() async {
    try {
      final jsonString =
          LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchband);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<BandEntity> communtiy =
          jsonList.map((e) => BandEntity.fromJson(e)).toList();
      debugPrint("recent communtiy  ${communtiy.length}");
      return communtiy;
    } catch (value) {
      debugPrint("errror $value");
      return [];
    }
  }

  Future<void> removeQuestionAtIndex(int index) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchband);
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
        key: SharedPreferenceKeys.recentSearchband,
        value: jsonEncode(jsonList),
      );
    }
  }
}
