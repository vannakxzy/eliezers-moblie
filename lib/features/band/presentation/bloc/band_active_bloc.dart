import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../data/models/band/band_model.dart';
import '../../domain/entities/band_entity.dart';
import '../../domain/usecase/get_band_usecase.dart';
import '../../domain/usecase/leave_from_band_usecase.dart';
import '../../domain/usecase/read_message_band_usecase.dart';

part 'band_active_event.dart';
part 'band_active_state.dart';
part 'band_active_bloc.freezed.dart';

@Injectable()
class bandActiveBloc extends BaseBloc<bandActiveEvent, bandActiveState> {
  bandActiveBloc(this._getbandUsecase, this._leavebandUsecase,
      this._readMessagebandUsecase)
      : super(_Initial()) {
    on<RefreshPageEvent>(_refeschPage);
    on<InitPageEvent>(_initPage);
    on<ClickLeave>(_clickLeave);
    on<ClickbandEvent>(_clickband);
  }
  final ReadMessagebandUsecase _readMessagebandUsecase;
  final GetbandUsecase _getbandUsecase;
  final LeavebandUsecase _leavebandUsecase;

  FutureOr<void> _initPage(
      InitPageEvent event, Emitter<bandActiveState> emit) async {
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
      RefreshPageEvent event, Emitter<bandActiveState> emit) async {
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

  FutureOr<void> _clickLeave(
      ClickLeave event, Emitter<bandActiveState> emit) async {
    await runAppCatching(
      () async {
        List<BandEntity> comm = [...state.band];
        comm.removeAt(event.index);
        final bandId = comm[event.index].id;
        emit(state.copyWith(band: comm));
        await _leavebandUsecase.excecute(bandId);
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _clickband(
      ClickbandEvent event, Emitter<bandActiveState> emit) async {
    await runAppCatching(
      () async {
        final band = [...state.band];
        BandEntity currentband = band[event.index];
        band[event.index] = currentband.copyWith(unread: 0);
        appRoute.push(AppRouteInfo.bandDetail(currentband, currentband.id));
        emit(state.copyWith(band: band));
        await _readMessagebandUsecase.excecute(currentband.id);
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
      },
    );
  }
}
