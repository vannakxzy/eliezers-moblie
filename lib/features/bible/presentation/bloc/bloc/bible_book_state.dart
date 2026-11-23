part of 'bible_book_bloc.dart';

@freezed
class BibleBookState extends BaseState with _$BibleBookState {
  const factory BibleBookState({
    @Default(true) bool isloading,
    @Default([]) List<BibleContentEntity> bible,
  }) = _Initial;
}
