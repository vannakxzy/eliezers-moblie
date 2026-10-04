import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../domain/entities/band_permission_entity.dart';
import '../../../domain/usecase/update_band_permission_usecase.dart';

part 'band_permissions_event.dart';
part 'band_permissions_state.dart';
part 'band_permissions_bloc.freezed.dart';

@Injectable()
class bandPermissionsBloc
    extends BaseBloc<bandPermissionsEvent, bandPermissionsState> {
  bandPermissionsBloc(this._updatebandPermission) : super(_Initial()) {
    on<CreateDiscussionChange>(_createDiscuustion);
    on<CreateQuestionChanged>(_createQuestionChanged);
    on<SendMessageChanged>(_sendMessage);
    on<AddMemberChanged>(_addMember);
    on<RecectionChanged>(_recention);
    on<ChnageInfoChanged>(_changeInfo);
    on<ClickSave>(_clickSave);
    on<InitPage>(_initPage);
  }

  final UpdatebandPermissionUsecase _updatebandPermission;
  FutureOr<void> _createQuestionChanged(
      CreateQuestionChanged event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(createQuestion: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _initPage(InitPage event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: event.permission,
        oldPermission: event.permission,
        permissionUpdated: event.permission));
    enableUpdate(emit);
  }

  FutureOr<void> _createDiscuustion(
      CreateDiscussionChange event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(createDiscussion: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _addMember(
      AddMemberChanged event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(addMember: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _sendMessage(
      SendMessageChanged event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(sendMessage: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _recention(
      RecectionChanged event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(reaction: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _changeInfo(
      ChnageInfoChanged event, Emitter<bandPermissionsState> emit) {
    emit(state.copyWith(
        permission: state.permission.copyWith(changeInfo: event.value)));
    enableUpdate(emit);
  }

  FutureOr<void> _clickSave(
      ClickSave event, Emitter<bandPermissionsState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isUpdate: false));
        emit(state.copyWith(permissionUpdated: state.permission));
        await _updatebandPermission.excecute(bandPermissionInput(
            id: event.id,
            band_id: state.permission.bandId,
            add_member: state.permission.addMember,
            change_info: state.permission.changeInfo,
            create_discussion: state.permission.createDiscussion,
            create_question: state.permission.createQuestion,
            reaction: state.permission.reaction,
            send_message: state.permission.sendMessage));
      },
      onError: (error) async {
        debugPrint("you have been on catch $error");
      },
    );
  }

  void enableUpdate(Emitter<bandPermissionsState> emit) {
    if (state.oldPermission == state.permission) {
      emit(state.copyWith(isUpdate: false));
    } else {
      emit(state.copyWith(isUpdate: true));
    }
  }
}
