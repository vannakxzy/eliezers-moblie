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
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../../data/models/profile/profile_model.dart';
import '../../../../domain/usecase/get_search_user_usecase.dart';

import '../../../../../profile/domain/entities/profile_entity.dart';

part 'result_user_event.dart';
part 'result_user_state.dart';
part 'result_user_bloc.freezed.dart';

@Injectable()
class ResultUserBloc extends BaseBloc<ResultUserEvent, ResultUserState> {
  final GetSearchUserUsecase _searchUserUsecase;
  ResultUserBloc(this._searchUserUsecase) : super(const _Initial()) {
    on<SearchUserEvent>(_searchUser);
    on<RefreshPage>(_refreshpage);
    on<ClickUser>(_clickUser);
    on<RemoveIndex>(_removeIndex);
    on<RemoveAll>(_removeAll);
  }
  FutureOr<void> _searchUser(
      SearchUserEvent event, Emitter<ResultUserState> emit) async {
    final recentSearch = await loadProfiles();
    emit(state.copyWith(recentSearch: recentSearch));

    if (event.q.isNotEmpty) {
      await runAppCatching(
        () async {
          final recentSearch = await loadProfiles();
          emit(state.copyWith(recentSearch: recentSearch));
          emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
          final userRespose = await _searchUserUsecase
              .excecute(UserInput(q: event.q, page: state.page));
          emit(state.copyWith(
              profile: userRespose.data.toListEntity(),
              isloading: false,
              page: state.page + 1));
          if (state.page > userRespose.mate!.lastPage) {
            emit(state.copyWith(isMorePage: false));
          }
        },
        onError: (error) async {
          emit(state.copyWith(isloading: false));
          debugPrint("catch $error");
        },
      );
    }
  }

  FutureOr<void> _refreshpage(
      RefreshPage event, Emitter<ResultUserState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final userRespose = await _searchUserUsecase
            .excecute(UserInput(q: event.q, page: state.page));
        emit(state.copyWith(
            profile: userRespose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        if (state.page > userRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
        debugPrint("catch $error");
      },
    );
  }

  FutureOr<void> _clickUser(
      ClickUser event, Emitter<ResultUserState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.user.id));
    storUser(event.user);
  }

  FutureOr<void> _removeAll(
      RemoveAll event, Emitter<ResultUserState> emit) async {
    await LocalStorage.remove(SharedPreferenceKeys.recentSearchUser);
    emit(state.copyWith(recentSearch: []));
  }

  FutureOr<void> _removeIndex(
      RemoveIndex event, Emitter<ResultUserState> emit) {
    final recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    removeUserAtIndex(event.index);
  }

  Future<void> storUser(ProfileEntity user) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchUser);
    List<dynamic> jsonList = [];
    if (jsonString.isNotEmpty) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        jsonList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        jsonList = [decoded];
      }
    }
    jsonList.removeWhere((e) => e['id'] == user.id);
    jsonList.insert(0, user.toJson());
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearchUser,
      value: jsonEncode(jsonList),
    );
  }

  Future<void> removeUserAtIndex(int index) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchUser);
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
        key: SharedPreferenceKeys.recentSearchUser,
        value: jsonEncode(jsonList),
      );
    }
  }

  Future<List<ProfileEntity>> loadProfiles() async {
    try {
      final jsonString =
          LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchUser);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<ProfileEntity> users =
          jsonList.map((e) => ProfileEntity.fromJson(e)).toList();
      debugPrint("recent user  ${users.length}");
      return users;
    } catch (value) {
      debugPrint("errror $value");
      return [];
    }
  }
}
