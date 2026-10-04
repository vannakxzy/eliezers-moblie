import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../domain/entities/band_entity.dart';
import '../../../domain/entities/band_permission_entity.dart';
import '../../../domain/usecase/update_band_usecase.dart';

part 'manage_band_bloc.freezed.dart';
part 'manage_band_event.dart';
part 'manage_band_state.dart';

@Injectable()
class ManagebandBloc extends BaseBloc<ManagebandEvent, ManageBandState> {
  final UpdatebandUsecase _updatebandUsecase;
  ManagebandBloc(this._updatebandUsecase) : super(_Initial()) {
    on<ClickPermission>(_clickbandPermission);
    on<InitPageEvent>(_initPage);
    on<ClickPinkImage>(_clickPickImage);
    on<ClickOutSidePickImage>(_clickOutSide);
    on<TitleChanged>(_titleChanged);
    on<DesChanged>(_desChanged);
    on<ClcikUpdateImage>(_clcikUpdateImage);
    on<ClickSave>(_clickSave);
    on<bandTypeChanged>(_typeChanged);
    on<ClickMemberEvent>(_clickMember);
    on<ClickAdministartor>(_clickAdmin);
    on<UpdatePermission>(_updatePermission);
  }
  FutureOr<void> _clickbandPermission(
      ClickPermission event, Emitter<ManageBandState> emit) async {
    appRoute.push(AppRouteInfo.bandPermission(event.band));
  }

  FutureOr<void> _clickMember(
      ClickMemberEvent event, Emitter<ManageBandState> emit) async {
    List newMember = [];
    newMember =
        await appRoute.push(AppRouteInfo.bandMember(event.band)) as List;
    debugPrint("newMember ${newMember.length}");
    emit(state.copyWith(
        band:
            state.band.copyWith(member: state.band.member + newMember.length)));
  }

  FutureOr<void> _clickAdmin(
      ClickAdministartor event, Emitter<ManageBandState> emit) async {
    appRoute.push(AppRouteInfo.bandMember(event.band));
  }

  FutureOr<void> _titleChanged(
      TitleChanged event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(
        band: state.band.copyWith(name: event.value), title: event.value));
    enableSaveButtiion(emit);
  }

  FutureOr<void> _updatePermission(
      UpdatePermission event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(
        band: state.band.copyWith(permission: event.permission)));
  }

  FutureOr<void> _desChanged(DesChanged event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(
        band: state.band.copyWith(description: event.value), des: event.value));
    enableSaveButtiion(emit);
  }

  FutureOr<void> _clcikUpdateImage(
      ClcikUpdateImage event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(image: event.file));
    enableSaveButtiion(emit);
  }

  FutureOr<void> _clickOutSide(
      ClickOutSidePickImage event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(showPickImage: false));
  }

  FutureOr<void> _clickPickImage(
      ClickPinkImage event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(showPickImage: !state.showPickImage));
  }

  FutureOr<void> _typeChanged(
      bandTypeChanged event, Emitter<ManageBandState> emit) {
    emit(state.copyWith(
      band: state.band.copyWith(isPublic: event.value),
    ));
    enableSaveButtiion(emit);
  }

  void enableSaveButtiion(Emitter<ManageBandState> emit) {
    if (state.oldband != state.band || state.image != null) {
      emit(state.copyWith(enableSave: true));
    } else {
      emit(state.copyWith(enableSave: false));
    }
  }

  FutureOr<void> _initPage(InitPageEvent event, Emitter<ManageBandState> emit) {
    BandEntity band = event.band;
    emit(state.copyWith(
      band: band,
      oldband: band,
      bandUpdated: event.band,
      titleController: TextEditingController(text: band.name),
      desController: TextEditingController(text: band.description),
      des: band.description,
      title: band.name,
    ));
  }

  FutureOr<void> _clickSave(
      ClickSave event, Emitter<ManageBandState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(enableSave: false));
        emit(state.copyWith(oldband: state.band, bandUpdated: state.band));
        final image = await imageToBase64(state.image);
        final input = bandInput(
            id: event.bandId,
            name: state.band.name,
            description: state.band.description,
            image: image,
            is_private: state.band.isPublic);
        await _updatebandUsecase.excecute(input);
        notifyGlobal(state);
      },
      onError: (error) async {
        debugPrint("you have been on catch ");
      },
    );
  }
}
