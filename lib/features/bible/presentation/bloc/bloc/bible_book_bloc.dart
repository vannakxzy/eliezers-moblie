import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import '../../../domain/entities/bible_content_entity.dart';

part 'bible_book_event.dart';
part 'bible_book_state.dart';
part 'bible_book_bloc.freezed.dart';

@Injectable()
class BibleBookBloc extends BaseBloc<BibleBookEvent, BibleBookState> {
  BibleBookBloc() : super(const _Initial()) {
    on<LoadingBibleFromBiblePage>(_loadingBibleFromBiblePage);
  }
  FutureOr<void> _loadingBibleFromBiblePage(
      LoadingBibleFromBiblePage event, Emitter<BibleBookState> emit) async {
    emit(state.copyWith(bible: event.bible));
    debugPrint("bible leeee ${state.bible.length}");
  }
}
