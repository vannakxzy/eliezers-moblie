import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../../data/models/band/band_model.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/usecase/cancel_request_band_usecase.dart';
import '../../../domain/usecase/get_band_usecase.dart';

part 'band_pendding_event.dart';
part 'band_pendding_state.dart';
part 'band_pendding_bloc.freezed.dart';

@Injectable()
class bandPenddingBloc extends BaseBloc<bandPenddingEvent, bandPenddingState> {
  bandPenddingBloc(this._getbandUsecase, this._cancelRequestbandUsecase)
      : super(const _Initial()) {
    on<RefreshPage>(_refeschPage);
    on<ClickCancel>(_clickCancel);
    on<InitPageEvent>(_initPage);
    on<Clickband>(_clickband);
  }
  final GetbandUsecase _getbandUsecase;
  final CancelRequestbandUsecase _cancelRequestbandUsecase;

  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<bandPenddingState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final response = await _getbandUsecase.excecute(
            GetbandInput(q: '', page: state.page, status: state.status));
        List<BandEntity> all = [...state.band];
        all.addAll(response.data.toListEntity());
        emit(state.copyWith(isLoading: false, band: all, page: state.page + 1));

        emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _refeschPage(
      RefreshPage event, Emitter<bandPenddingState> emit) async {
    await runAppCatching(
      () async {
        debugPrint("band jjsdsjjj ${state.band.length}");
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _getbandUsecase.excecute(
            GetbandInput(q: '', page: state.page, status: state.status));
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

  FutureOr<void> _clickband(Clickband event, Emitter<bandPenddingState> emit) {
    BandEntity band = state.band[event.index];
    appRoute.push(AppRouteInfo.bandDetail(band, band.id));
  }

  FutureOr<void> _clickCancel(
      ClickCancel event, Emitter<bandPenddingState> emit) async {
    await runAppCatching(
      () async {
        final band = [...state.band];
        int bandId = band[event.index].id;
        band.removeAt(event.index);
        emit(state.copyWith(band: band));
        await _cancelRequestbandUsecase.excecute(bandId);
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
        emit(state.copyWith(isMorePage: false));
      },
    );
  }
}
