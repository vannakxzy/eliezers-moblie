part of 'bible_book_bloc.dart';

class BibleBookEvent extends BaseEvent {}

@freezed
class LoadingBibleFromBiblePage extends BibleBookEvent
    with _$LoadingBibleFromBiblePage {
  const factory LoadingBibleFromBiblePage(List<BibleContentEntity> bible) =
      _LoadingBibleFromBiblePage;
}
