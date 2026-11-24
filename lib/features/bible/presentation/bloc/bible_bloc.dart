import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/locals/local_storage_service/local_storage_service.dart';
import '../../../../data/models/bible/bible_content_model.dart';
import '../../../../data/models/bible/bible_content_response_model.dart';
import '../../../../data/models/bible/bible_local_model.dart';
import '../../../../data/models/bible/bible_passege_model.dart';
import '../../domain/entities/bible_content_entity.dart';
import '../../domain/entities/bible_language_entity.dart';
import '../../domain/entities/bible_passage_entity.dart';
import '../../domain/usecase/get_bible_book_usecase.dart';
import '../../domain/usecase/get_bible_landuage.dart';
import '../../domain/usecase/get_passage_bible_usecase.dart';

part 'bible_event.dart';
part 'bible_state.dart';
part 'bible_bloc.freezed.dart';

@Injectable()
class BibleBloc extends BaseBloc<BibleEvent, BibleState> {
  BibleBloc(this._getBibleBookUsecase, this._getPassageBibleUsecase,
      this._getBiblelanguage)
      : super(const _Initial()) {
    on<InitPage>(_initPage);
    on<ClickBackChapter>(_clickBackChapter);
    on<ClickNextChapter>(_clickNextChapter);
    on<LoadBibleChapter>(_loadBibleChapter);
  }
  final GetBibleBookUsecase _getBibleBookUsecase;
  final GetBibleLanduage _getBiblelanguage;
  // final GetBib
  final GetPassageBibleUsecase _getPassageBibleUsecase;
  FutureOr<void> _loadBibleChapter(
      LoadBibleChapter event, Emitter<BibleState> emit) async {
    await runAppCatching(
      () async {
        try {
          emit(state.copyWith(
              bibleIndex: event.bibleIndex, chapterIndex: event.chapterIndex));
          String passageId = state
              .bible[state.bibleIndex].chapters[state.chapterIndex].passage_id;
          debugPrint("chaper index ${state.chapterIndex}");
          final resposebiblecontant =
              await _getPassageBibleUsecase.excecute(
              GetPassageBibleParams(bibleId: 111, passageId: passageId));
          emit(state.copyWith(
              biblePassageEntity: resposebiblecontant.toEntity()));
          emit(state.copyWith(isloading: false));
        } catch (vlaue) {
          debugPrint("error $vlaue");
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _initPage(
    InitPage event,
    Emitter<BibleState> emit,
  ) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        try {
          emit(state.copyWith(isloading: true));
          final respone = await _getBibleBookUsecase.excecute(111);
          emit(state.copyWith(bible: respone.data!.toListEntity()));
          final passageId = state.bible[0].chapters[0].passage_id;
          final passageResponse =
              await _getPassageBibleUsecase.excecute(
              GetPassageBibleParams(bibleId: 1111, passageId: passageId));
          emit(state.copyWith(
            biblePassageEntity: passageResponse.toEntity(),
            isloading: false,
          ));
          debugPrint('Bible initialization completed');
          final biblelanguage = await _getBiblelanguage.excecute('');
          emit(state.copyWith(bibleLanguage: biblelanguage.toListEntity()));
        } catch (error, stackTrace) {
          debugPrint('Bible initialization error: $error');
          debugPrintStack(stackTrace: stackTrace);

          emit(state.copyWith(isloading: false));
        }
      },
      onError: (error) async {
        debugPrint('Bible error: $error');
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _clickNextChapter(
      ClickNextChapter event, Emitter<BibleState> emit) async {
    await runAppCatching(
      () async {
        int newChapterIndex = state.chapterIndex + 1;
        String passageId =
            state.bible[state.bibleIndex].chapters[newChapterIndex].passage_id;
        emit(state.copyWith(chapterIndex: newChapterIndex));
        debugPrint("chaper index ${state.chapterIndex}");
        final resposebiblecontant =
            await _getPassageBibleUsecase.excecute(
            GetPassageBibleParams(bibleId: 111, passageId: passageId));
        emit(
            state.copyWith(biblePassageEntity: resposebiblecontant.toEntity()));
        emit(state.copyWith(isloading: false));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }
  FutureOr<void> _clickBackChapter(
      ClickBackChapter event, Emitter<BibleState> emit) async {
    await runAppCatching(
      () async {
        int newChapterIndex = state.chapterIndex - 1;
        String passageId =
            state.bible[state.bibleIndex].chapters[newChapterIndex].passage_id;
        emit(state.copyWith(chapterIndex: newChapterIndex));
        debugPrint("chaper index ${state.chapterIndex}");
        final resposebiblecontant =
            await _getPassageBibleUsecase.excecute(
            GetPassageBibleParams(bibleId: 1111, passageId: passageId));
        emit(
            state.copyWith(biblePassageEntity: resposebiblecontant.toEntity()));
        emit(state.copyWith(isloading: false));
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

}
