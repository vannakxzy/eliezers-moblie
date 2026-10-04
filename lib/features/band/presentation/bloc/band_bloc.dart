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
import '../../domain/usecase/create_band_usecase.dart';
import '../../domain/usecase/get_band_usecase.dart';
import '../../domain/usecase/leave_from_band_usecase.dart';
import '../../domain/usecase/read_message_band_usecase.dart';

part 'band_bloc.freezed.dart';
part 'band_event.dart';
part 'band_state.dart';

@Injectable()
class bandBloc extends BaseBloc<BandEvent, BandState> {
  bandBloc(this._getbandUsecase, this._leavebandUsecase,
      this._readMessagebandUsecase, this._createbandUsecase)
      : super(const _Initial()) {
    on<ClickRefreshPage>(_refeschPage);
    on<InitPage>(_initPage);
    on<ClickLeave>(_clickLeave);
    on<Clickband>(_clickband);
    on<ClickCreateband>(_clickCreateband);
  }

  final GetbandUsecase _getbandUsecase;
  final LeavebandUsecase _leavebandUsecase;
  final ReadMessagebandUsecase _readMessagebandUsecase;
  final CreatebandUsecase _createbandUsecase;

  FutureOr<void> _clickCreateband(
      ClickCreateband event, Emitter<BandState> emit) async {
    await runAppCatching(
      () async {
        bandInput input =
            await appRoute.push(AppRouteInfo.createband()) as bandInput;
        final before = [...state.band];
        debugPrint("inpu create communiyt : ${state.band.length}");
        before.insert(
            0,
            BandEntity(
                isCreated: false,
                description: input.description,
                name: input.name));
        emit(state.copyWith(band: before));
        debugPrint("inpu create communiyt : ${state.band.length}");
        final newband = await _createbandUsecase.excecute(input);
        final after = [...state.band];
        after.first = newband;
        emit(state.copyWith(band: after));
        debugPrint("inpu create communiyt : ${state.band.length}");
      },
    );
  }

  FutureOr<void> _initPage(InitPage event, Emitter<BandState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final response = await _getbandUsecase
            .excecute(GetbandInput(q: '', page: state.page));
        // List<BandEntity> all = [...state.band];
        // all.addAll(response.data.toListEntity());
        // emit(state.copyWith(isLoading: false, band: all, page: state.page + 1));

        emit(state.copyWith(isMorePage: response.pagination!.has_next_page));
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _refeschPage(
      ClickRefreshPage event, Emitter<BandState> emit) async {
    await runAppCatching(
      () async {
        debugPrint("band jjsdsjjj ${state.band.length}");
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _getbandUsecase
            .excecute(GetbandInput(q: '', page: state.page));
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

  FutureOr<void> _clickLeave(ClickLeave event, Emitter<BandState> emit) async {
    await runAppCatching(
      () async {
        List<BandEntity> comm = [...state.band];
        final bandId = comm[event.index].id;

        comm.removeAt(event.index);
        emit(state.copyWith(band: comm));
        await _leavebandUsecase.excecute(bandId);
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _clickband(Clickband event, Emitter<BandState> emit) async {
    await runAppCatching(
      () async {
        final band = [...state.band];
        BandEntity currentband = band[event.index];
        band[event.index] = currentband.copyWith();
        emit(state.copyWith(band: band));
        await _readMessagebandUsecase.excecute(currentband.id);

        bool isleave = await appRoute
            .push(AppRouteInfo.bandDetail(currentband, currentband.id)) as bool;
        if (isleave) {
          final comm = [...state.band];
          comm.removeAt(event.index);
          emit(state.copyWith(band: comm));
        }
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
      },
    );
  }
}
