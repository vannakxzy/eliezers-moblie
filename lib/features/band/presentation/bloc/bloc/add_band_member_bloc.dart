// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/bloc.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../data/models/profile/profile_model.dart';
import '../../../../profile/domain/entities/profile_entity.dart';
import '../../../../search/domain/usecase/get_search_user_usecase.dart';
import '../../../domain/entities/band_member_entity.dart';
import '../../../domain/usecase/add_band_member_usecase.dart';

part 'add_band_member_event.dart';
part 'add_band_member_state.dart';
part 'add_band_member_bloc.freezed.dart';

@Injectable()
class AddbandMemberBloc
    extends BaseBloc<AddbandMemberEvent, AddbandMemberState> {
  AddbandMemberBloc(this._searchUserUsecase, this._addbandMemberUsecase)
      : super(_Initial()) {
    on<InitPage>(_intiPage);
    on<TextChanged>(_textChanged);
    on<SelectUser>(_selectUser);
    on<RemoverSelectedIndex>(_removeSelectIndex);
    on<RemoveAllSelected>(_removeAllSelected);
    on<ClickAddMember>(_addMember);
    on<ClickUser>(_clickUser);
    on<ClearTextSearch>(_clearText);
  }
  final GetSearchUserUsecase _searchUserUsecase;
  final AddbandMemberUsecase _addbandMemberUsecase;
  FutureOr<void> _intiPage(
      InitPage event, Emitter<AddbandMemberState> emit) async {
    await runAppCatching(() async {});
  }

  FutureOr<void> _clearText(
      ClearTextSearch event, Emitter<AddbandMemberState> emit) async {
    emit(state.copyWith(
        textSearch: "", textController: TextEditingController(text: "")));
  }

  FutureOr<void> _clickUser(
      ClickUser event, Emitter<AddbandMemberState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _addMember(
      ClickAddMember event, Emitter<AddbandMemberState> emit) async {
    await runAppCatching(
      () async {
        List<bandMemberEntity> newNumber = [];
        newNumber.addAll(state.seletedUser
            .map((user) => bandMemberEntity(user: user, role: "member")));
        emit(state.copyWith(newMember: newNumber));
        appRoute.pop(result: state.newMember);
        // await _addbandMemberUsecase.excecute(AddbandMemberInput(
        //     user_id: state.seletedUser.map((e) => e.id).toList(),
        //     band_id: event.bandId,
        //     role: "member"));
      },
      onError: (error) async {
        debugPrint("add member error :  $error");
      },
    );
  }

  FutureOr<void> _textChanged(
      TextChanged event, Emitter<AddbandMemberState> emit) async {
    emit(state.copyWith(textSearch: event.value));
    if (event.value != "") {
      await runAppCatching(
        () async {
          emit(state.copyWith(isLoading: true));
          final userRespose = await _searchUserUsecase.excecute(UserInput(
              q: event.value, page: state.page, band_id: event.bandId));
          emit(state.copyWith(
              user: userRespose.data.toListEntity(), isLoading: false));
        },
        onError: (error) async {
          emit(state.copyWith(isLoading: false));
          debugPrint("catch $error");
        },
      );
    }
  }

  FutureOr<void> _selectUser(
      SelectUser event, Emitter<AddbandMemberState> emit) {
    final selectUser = [...state.seletedUser];
    if (state.seletedUser.contains(event.user)) {
      selectUser.remove(event.user);
    } else {
      selectUser.add(event.user);
    }
    emit(state.copyWith(seletedUser: selectUser));
  }

  FutureOr<void> _removeSelectIndex(
      RemoverSelectedIndex event, Emitter<AddbandMemberState> emit) {
    final selectUser = [...state.seletedUser];
    selectUser.removeAt(event.index);
    emit(state.copyWith(seletedUser: selectUser));
  }

  FutureOr<void> _removeAllSelected(
      RemoveAllSelected event, Emitter<AddbandMemberState> emit) {
    final selectUser = [...state.seletedUser];
    selectUser.clear();
    emit(state.copyWith(seletedUser: selectUser));
  }
}
