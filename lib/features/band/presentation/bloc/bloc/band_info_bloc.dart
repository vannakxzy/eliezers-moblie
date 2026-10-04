import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../../../data/models/band/band_member_model.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/entities/band_member_entity.dart';
import '../../../domain/usecase/get_band_member_usecase.dart';
import '../../../domain/usecase/remove_band_member_usecase.dart';

part 'band_info_event.dart';
part 'band_info_state.dart';
part 'band_info_bloc.freezed.dart';

@Injectable()
class bandInfoBloc extends BaseBloc<bandInfoEvent, bandInfoState> {
  bandInfoBloc(this._getbandMemberUsecase, this._removebandMemberUsecase)
      : super(_Initial()) {
    on<InitPage>(_initPage);
    on<RefreshPage>(_refeschPage);
    on<ClcikRemovebandMember>(_removebandMember);
    on<ClickAddMember>(_clickAddMember);
    on<ClickMember>(_clickMember);
    on<UpdateNewMemberEvent>(_updateNewMemer);
    on<ClickEdit>(_clickEdit);
  }
  final GetbandMemberUsecase _getbandMemberUsecase;
  final RemovebandMemberUsecase _removebandMemberUsecase;
  FutureOr<void> _removebandMember(
      ClcikRemovebandMember event, Emitter<bandInfoState> emit) async {
    await runAppCatching(
      () async {
        final member = [...state.member];
        final currentMember = member[event.index];
        member.removeAt(event.index);
        emit(state.copyWith(member: member));
        await _removebandMemberUsecase.excecute(BandIdUserIdInput(
            user_id: currentMember.user.id, band_id: event.bandId));
      },
    );
  }

  FutureOr<void> _clickAddMember(
      ClickAddMember event, Emitter<bandInfoState> emit) async {
    appRoute.push(AppRouteInfo.addbandMember(event.band));
  }

  FutureOr<void> _clickEdit(
      ClickEdit event, Emitter<bandInfoState> emit) async {
    final BandEntity response =
        await appRoute.push(AppRouteInfo.manageband(state.band)) as BandEntity;
    emit(state.copyWith(band: response));
  }

  FutureOr<void> _updateNewMemer(
      UpdateNewMemberEvent event, Emitter<bandInfoState> emit) async {
    final members = [...state.member];
    members.insertAll(0, event.member);
    emit(state.copyWith(member: members));
  }

  FutureOr<void> _clickMember(ClickMember event, Emitter<bandInfoState> emit) {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _initPage(InitPage event, Emitter<bandInfoState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, band: event.band));
        final response = await _getbandMemberUsecase
            .excecute(bandIdPageInput(band_id: event.band.id));
        List<bandMemberEntity> all = [...state.member];
        all.addAll(response.data.toListEntity());
        emit(state.copyWith(
            isLoading: false, member: all, page: state.page + 1));
        if (state.page > response.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
        debugPrint("you have been on catch $error");
      },
    );
  }

  FutureOr<void> _refeschPage(
      RefreshPage event, Emitter<bandInfoState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _getbandMemberUsecase
            .excecute(bandIdPageInput(band_id: event.band.id));
        emit(state.copyWith(
            isLoading: false,
            member: response.data.toListEntity(),
            page: state.page + 1));
        if (state.page > response.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
        emit(state.copyWith(isMorePage: false));
      },
    );
  }
}
