// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../data/data_sources/remotes/category_service.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecase/delete_category_usecase.dart';
import '../../domain/usecase/get_category_usecase.dart';
import '../../domain/usecase/merge_cateogry_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../domain/usecase/reorder_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

@Injectable()
class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState> {
  CategoryBloc(
    this._GetCategoryEventUsecase,
    this._mergeCategoryUseCase,
    this._deleteCategoryUsecase,
    this._reorderCategoryUsecase,
  ) : super(const CategoryState()) {
    on<GetCategoryEvent>(_GetCategoryEvent);
    on<UpdateCategoryEvent>(_updateCategory);
    on<ClickMergeCategoryEvent>(_mergeCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
    on<MergeCategoryEvent>(_clickMergeCategory);
    on<Reordered>(_reordered);
    on<ClickCreateCategory>(_clickCreateGategory);
  }
  final GetCategoryEventUsecase _GetCategoryEventUsecase;
  final MergeCategoryUseCase _mergeCategoryUseCase;
  final DeleteCategoryUsecase _deleteCategoryUsecase;
  final ReorderCategoryUsecase _reorderCategoryUsecase;
  FutureOr<void> _updateCategory(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) {
    final cateogry = [...state.category];
    final currentCateogry = cateogry[event.index!];
    cateogry[event.index!] =
        currentCateogry.copyWith(name: event.name, cover: event.cover);
    emit(state.copyWith(category: cateogry));
  }

  FutureOr<void> _reordered(
      Reordered event, Emitter<CategoryState> emit) async {
    await runAppCatching(
      () async {
        final cateogry = [...state.category];
        int oldId = cateogry[event.oldIndex].id;
        int newId = cateogry[event.newIndex].id;
        final oldItem = cateogry.removeAt(event.oldIndex);
        cateogry.insert(event.newIndex, oldItem);
        emit(state.copyWith(category: cateogry));
        await _reorderCategoryUsecase
            .excecute(ReOrderCategoryInput(newId: newId, oldId: oldId));
      },
      onError: (error) async {
        debugPrint("you have been error $error");
      },
    );
  }

  FutureOr<void> _deleteCategory(
      DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    debugPrint("event.index ${event.index}");
    int categoryId = state.category[event.index].id;
    await _deleteCategoryUsecase.excecute(categoryId);
    List<CategoryEntity> category01 = [...state.category];
    debugPrint("ecnnn ${category01.length}");
    category01.removeAt(event.index);
    emit(state.copyWith(category: category01));
    appRoute.pop();
    appRoute.pop();
  }

  FutureOr<void> _clickMergeCategory(
      MergeCategoryEvent event, Emitter<CategoryState> emit) async {
    await runAppCatching(
      () async {
        await _mergeCategoryUseCase.excecute(Mergeinput(
          from: state.category[event.fromIndex].id,
          to: state.category[event.toIndex].id,
        ));
        final category = [...state.category];
        CategoryEntity currentTo = category[event.toIndex];
        CategoryEntity currentFrom = category[event.fromIndex];
        category[event.toIndex] =
            currentTo.copyWith(count: currentTo.count! + currentFrom.count!);
        category[event.fromIndex] = currentFrom.copyWith(count: 0);
        emit(state.copyWith(category: category));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _mergeCategory(
      ClickMergeCategoryEvent event, Emitter<CategoryState> emit) async {
    await runAppCatching(() async {
      await _mergeCategoryUseCase.excecute(Mergeinput(
        from: state.category[event.formIndex].id,
        to: state.category[event.toIndex].id,
      ));
      final category = [...state.category];
      CategoryEntity currentTo = category[event.toIndex];
      CategoryEntity currentFrom = category[event.formIndex];
      category[event.toIndex] =
          currentTo.copyWith(count: currentTo.count! + currentFrom.count!);
      category[event.formIndex] = currentFrom.copyWith(count: 0);
      emit(state.copyWith(category: category));
    });
  }

  Future<void> _GetCategoryEvent(
      GetCategoryEvent event, Emitter<CategoryState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final category = await _GetCategoryEventUsecase.excecute();
        emit(state.copyWith(category: category, isloading: false));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  Future<void> _clickCreateGategory(
      ClickCreateCategory event, Emitter<CategoryState> emit) async {
    await runAppCatching(
      () async {
        final CategoryEntity respose = await appRoute
            .push(AppRouteInfo.createCategory(questionId: 0)) as CategoryEntity;
        final category = [...state.category];
        category.add(respose);
        emit(state.copyWith(category: category));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  // FutureOr<void> _deleteCategory(
  //     ClickDeletecategoryEvent event, Emitter<CategoryState> emit) async {
  //   await _deleteCategoryUsecase.excecute(state.category[event.index].id);
  //   List<CategoryEntity> category01 = [...state.category];
  //   category01.removeAt(event.index);
  //   emit(state.copyWith(category: category01));
  //   appRoute.pop();
  //   appRoute.pop();
  // }

  // FutureOr<void> _updateCategory(
  //     ClickUpdateCategoryEvent event, Emitter<CategoryState> emit) async {
  //   await runAppCatching(
  //     () async {
  //       final cateogry = [...state.category];
  //       final currentCateogry = cateogry[event.index];
  //       cateogry[event.index] =
  //           currentCateogry.copyWith(name: event.bookName, cover: event.cover);
  //       emit(state.copyWith(category: cateogry));
  //     },
  //     onError: (error) async {
  //       debugPrint("errrdfdfo $error");
  //     },
  //   );
  // }
}
