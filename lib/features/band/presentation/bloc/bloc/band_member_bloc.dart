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

part 'band_member_event.dart';
part 'band_member_state.dart';
part 'band_member_bloc.freezed.dart';

@Injectable()
class bandMemberBloc extends BaseBloc<bandMemberEvent, bandMemberState> {
  bandMemberBloc(this._getbandMemberUsecase, this._removebandMemberUsecase)
      : super(_Initial()) {
    on<InitPage>(_initPage);
    on<ClickRemove>(_removebandMember);
    on<RefreshPage>(_refeschPage);
    on<ClickMember>(_clickMember);
    on<ClickAddMember>(_clickAddMember);
    on<TextChanged>(_textChanged);
    on<ClearTextSearch>(_clearText);
  }

  final GetbandMemberUsecase _getbandMemberUsecase;
  final RemovebandMemberUsecase _removebandMemberUsecase;
  FutureOr<void> _clickMember(
      ClickMember event, Emitter<bandMemberState> emit) {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _clearText(
      ClearTextSearch event, Emitter<bandMemberState> emit) {
    emit(state.copyWith(
        textSearch: '', textController: TextEditingController(text: "")));
  }

  FutureOr<void> _textChanged(
      TextChanged event, Emitter<bandMemberState> emit) async {
    emit(state.copyWith(textSearch: event.value));
    if (event.value != "") {
      await runAppCatching(
        () async {
          final response = await _getbandMemberUsecase.excecute(
              bandIdPageInput(band_id: event.bandId, name: state.textSearch));
          emit(state.copyWith(
              isLoading: false,
              member: response.data.toListEntity(),
              page: state.page + 1));
        },
        onError: (error) async {
          emit(state.copyWith(isLoading: false));
          debugPrint("catch $error");
        },
      );
    }
  }

  FutureOr<void> _removebandMember(
      ClickRemove event, Emitter<bandMemberState> emit) async {
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
      ClickAddMember event, Emitter<bandMemberState> emit) async {
    final member = await appRoute.push(AppRouteInfo.addbandMember(event.band))
        as List<bandMemberEntity>;
    final members = [...state.member];
    members.insertAll(0, member);
    emit(state.copyWith(member: members, newMember: member));
  }

  FutureOr<void> _refeschPage(
      RefreshPage event, Emitter<bandMemberState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true, page: 1, isMorePage: true));
        final response = await _getbandMemberUsecase.excecute(
            bandIdPageInput(band_id: event.bandId, name: state.textSearch));
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

  FutureOr<void> _initPage(
      InitPage event, Emitter<bandMemberState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final response = await _getbandMemberUsecase.excecute(
            bandIdPageInput(band_id: event.bandId, name: state.textSearch));
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
}
