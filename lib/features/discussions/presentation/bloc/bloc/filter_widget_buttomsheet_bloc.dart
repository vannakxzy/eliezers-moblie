import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import '../../../../../data/data_sources/remotes/home_api_service.dart';
import '../../../../../data/data_sources/remotes/post_service.dart';
import '../../../../../data/models/filter_entity.dart';
import '../../../../home/domain/usecase/count_result_filter_usecase.dart';
import '../../../../post/domain/entities/tag_entity.dart';
import '../../../../post/domain/usecase/get_tag_usecase.dart';

part 'filter_widget_buttomsheet_event.dart';
part 'filter_widget_buttomsheet_state.dart';
part 'filter_widget_buttomsheet_bloc.freezed.dart';

@Injectable()
class FilterWidgetButtomsheetBloc extends BaseBloc<FilterWidgetButtomsheetEvent,
    FilterWidgetButtomsheetState> {
  final GetTagUseCase _getTagUseCase;
  final CountResultFilterUsecase _countResultFilterUsecase;
  FilterWidgetButtomsheetBloc(
      this._getTagUseCase, this._countResultFilterUsecase)
      : super(_Initial()) {
    on<SearchTag>(_searchTag);
    on<SelectTag>(_selectTag);
    on<ClearTag>(_clearTag);
    on<ClearAllTag>(_clearAllTag);
    on<ClickLike>(_clickScore);
    on<ClickDate>(_clickDate);
    on<ClickStatus>(_clickStatus);
    on<InitPage>(_initPage);
    on<ClearFilter>(_clearFilter);
    on<ClickType>(_clickType);
  }
  FutureOr<void> _searchTag(
      SearchTag event, Emitter<FilterWidgetButtomsheetState> emit) async {
    await runAppCatching(
      () async {
        List<int> oldTag = state.filter.tag.map((item) => item.id).toList();
        final tag = await _getTagUseCase
            .excecute(TagInput(oldTag: oldTag, name: event.value));
        emit(state.copyWith(tags: tag));
        debugPrint("tags : ${state.tags}");
      },
      onError: (error) async {
        debugPrint("you have error ");
      },
    );
  }

  Future getResult(Emitter<FilterWidgetButtomsheetState> emit) async {
    await runAppCatching(() async {
      GetQuestionInput input = GetQuestionInput(
          date: state.filter.date,
          type: state.filter.type,
          like: state.filter.like,
          tags: state.filter.tag.map((item) => item.id).toList(),
          status: state.filter.status,
          band_id: state.filter.band_id);
      final count = await _countResultFilterUsecase.excecute(input);
      emit(state.copyWith(resultCount: count));
      debugPrint("resultl code ${state.resultCount}");
    }, onError: (value) async {
      debugPrint("resultl code $value");
    });
  }

  FutureOr<void> _selectTag(
      SelectTag event, Emitter<FilterWidgetButtomsheetState> emit) async {
    final select = [...state.filter.tag];
    select.add(state.tags[event.index]);
    emit(state.copyWith(
        filter: state.filter.copyWith(tag: select),
        searchText: TextEditingController(text: ""),
        tags: []));
    await getResult(emit);
  }

  FutureOr<void> _clearTag(
      ClearTag event, Emitter<FilterWidgetButtomsheetState> emit) async {
    final select = [...state.filter.tag];
    select.removeAt(event.index);
    emit(state.copyWith(filter: state.filter.copyWith(tag: select)));
    await getResult(emit);
  }

  FutureOr<void> _clearAllTag(
      ClearAllTag event, Emitter<FilterWidgetButtomsheetState> emit) async {
    emit(state.copyWith(filter: state.filter.copyWith(tag: [])));
    await getResult(emit);
  }

  FutureOr<void> _clickType(
      ClickType event, Emitter<FilterWidgetButtomsheetState> emit) async {
    if (event.value == state.filter.type) {
      emit(state.copyWith(filter: state.filter.copyWith(type: '')));
    } else {
      emit(state.copyWith(filter: state.filter.copyWith(type: event.value)));
    }
    await getResult(emit);
  }

  FutureOr<void> _clearFilter(
      ClearFilter event, Emitter<FilterWidgetButtomsheetState> emit) async {
    emit(state.copyWith(filter: FilterEntity()));
    await getResult(emit);
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<FilterWidgetButtomsheetState> emit) async {
    emit(state.copyWith(filter: event.filter));
    if (state.filter.activeFilterCount != 0) {
      await getResult(emit);
    }
  }

  FutureOr<void> _clickDate(
      ClickDate event, Emitter<FilterWidgetButtomsheetState> emit) async {
    if (event.value == state.filter.date) {
      emit(state.copyWith(filter: state.filter.copyWith(date: '')));
    } else {
      emit(state.copyWith(filter: state.filter.copyWith(date: event.value)));
    }
    await getResult(emit);
  }

  FutureOr<void> _clickStatus(
      ClickStatus event, Emitter<FilterWidgetButtomsheetState> emit) async {
    if (event.value == state.filter.status) {
      emit(state.copyWith(filter: state.filter.copyWith(status: '')));
    } else {
      emit(state.copyWith(filter: state.filter.copyWith(status: event.value)));
    }
    await getResult(emit);
  }

  FutureOr<void> _clickScore(
      ClickLike event, Emitter<FilterWidgetButtomsheetState> emit) async {
    if (event.value == state.filter.like) {
      emit(state.copyWith(filter: state.filter.copyWith(like: '')));
    } else {
      emit(state.copyWith(filter: state.filter.copyWith(like: event.value)));
    }
    await getResult(emit);
  }
}
