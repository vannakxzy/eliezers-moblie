part of 'bible_bloc.dart';

class BibleEvent extends BaseEvent {}

@freezed
class InitPage extends BibleEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}


@freezed
class ClickNextChapter extends BibleEvent with _$ClickNextChapter {
  const factory ClickNextChapter() = _ClickNextChapter;
}

@freezed
class ClickBackChapter extends BibleEvent with _$ClickBackChapter {
  const factory ClickBackChapter() = _ClickBackChapter;
}

@freezed
class LoadBibleChapter extends BibleEvent with _$LoadBibleChapter {
  const factory LoadBibleChapter(int bibleIndex, int chapterIndex) =
      _LoadBibleChapter;
}
