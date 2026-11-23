part of 'bible_bloc.dart';

@freezed
class BibleState extends BaseState with _$BibleState {
  const factory BibleState({
    @Default(true) bool isloading,
    @Default([]) List<BibleContentEntity> bible,
    BiblePassageEntity? biblePassageEntity,
    @Default(0) bibleIndex,
    @Default(0) chapterIndex,
  }) = _Initial;
}
