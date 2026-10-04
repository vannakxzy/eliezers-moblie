import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../app/base/bloc/bloc.dart';
import '../../../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../../../data/data_sources/remotes/search_service.dart';
import '../../../../../../post/domain/entities/tag_entity.dart';
import '../../../../../domain/usecase/search_tag_count_usercase.dart';

import '../../../../../../../data/models/post_question/tag_model.dart';

part 'result_tag_event.dart';
part 'result_tag_state.dart';
part 'result_tag_bloc.freezed.dart';

@Injectable()
class ResultTagBloc extends BaseBloc<ResultTagEvent, ResultTagState> {
  final SearchTagCountUsercase _searchTagCountUsercase;

  ResultTagBloc(this._searchTagCountUsercase) : super(const _Initial()) {
    on<GetTags>(_getTags);
    on<RefreshPageP>(_refreshPage);
    on<ClickTag>(_clicktTag);
    on<RemoveIndex>(_removeIndex);
    on<RemoveAll>(_removeAll);
  }
  FutureOr<void> _getTags(GetTags event, Emitter<ResultTagState> emit) async {
    final recentSearch = await loadtags();
    emit(state.copyWith(recentSearch: recentSearch));
    if (event.q != '') {
      await runAppCatching(() async {
        emit(state.copyWith(isloading: true));
        final tagRespose = await _searchTagCountUsercase
            .excecute(QPageInput(q: event.q, page: state.page));
        final all = [...state.tags];
        all.addAll(tagRespose.data.toListEntity());
        emit(state.copyWith(tags: all, isloading: false, page: state.page + 1));
        if (state.page > tagRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      }, onError: (error) async {
        emit(state.copyWith(isloading: false));

        debugPrint("you get error $error");
      });
    }
  }

  FutureOr<void> _refreshPage(
      RefreshPageP event, Emitter<ResultTagState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
      final tagRespose = await _searchTagCountUsercase
          .excecute(QPageInput(q: event.q, page: state.page));
      emit(state.copyWith(
          tags: tagRespose.data.toListEntity(),
          isloading: false,
          page: state.page + 1));
      if (state.page > tagRespose.mate!.lastPage) {
        emit(state.copyWith(isMorePage: false));
      }
    }, onError: (error) async {
      emit(state.copyWith(isloading: false));
      debugPrint("you get error $error");
    });
  }

  FutureOr<void> _clicktTag(
      ClickTag event, Emitter<ResultTagState> emit) async {
    appRoute.push(AppRouteInfo.questionTag(event.tag));
    storeTags(event.tag);
  }

  Future<void> storeTags(TagEntity tag) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchTag);
    List<dynamic> jsonList = [];
    if (jsonString.isNotEmpty) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        jsonList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        jsonList = [decoded];
      }
    }
    jsonList.removeWhere((e) => e['id'] == tag.id);
    jsonList.insert(0, tag.toJson());
    await LocalStorage.storeData(
      key: SharedPreferenceKeys.recentSearchTag,
      value: jsonEncode(jsonList),
    );
  }

  FutureOr<void> _removeIndex(RemoveIndex event, Emitter<ResultTagState> emit) {
    final recentSearch = [...state.recentSearch];
    recentSearch.removeAt(event.index);
    emit(state.copyWith(recentSearch: recentSearch));
    removeQuestionAtIndex(event.index);
  }

  FutureOr<void> _removeAll(
      RemoveAll event, Emitter<ResultTagState> emit) async {
    await LocalStorage.remove(SharedPreferenceKeys.recentSearchTag);
    emit(state.copyWith(recentSearch: []));
  }

  Future<List<TagEntity>> loadtags() async {
    try {
      final jsonString =
          LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchTag);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<TagEntity> tag = jsonList.map((e) => TagEntity.fromJson(e)).toList();
      debugPrint("recent tag  ${tag.length}");
      return tag;
    } catch (value) {
      debugPrint("errror $value");
      return [];
    }
  }

  Future<void> removeQuestionAtIndex(int index) async {
    final jsonString =
        LocalStorage.getStringValue(SharedPreferenceKeys.recentSearchTag);
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
        key: SharedPreferenceKeys.recentSearchTag,
        value: jsonEncode(jsonList),
      );
    }
  }
}
