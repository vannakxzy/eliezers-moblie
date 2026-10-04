part of 'musics_bloc.dart';

class MusicsState extends BaseEvent {}

@freezed
class InitPage extends MusicsState with _$InitPage {
  const factory InitPage(int page) = _InitPage;
}

@freezed
class ClickFavorite extends MusicsState with _$ClickFavorite {
  factory ClickFavorite(int index) = _ClickFavorite;
}

@freezed
class ClickMusics extends MusicsState with _$ClickMusics {
  factory ClickMusics(int index) = _ClickMusics;
}

@freezed
class ClickShare extends MusicsState with _$ClickShare {
  factory ClickShare() = _ClickShare;
}

@freezed
class ClickRefreshPage extends MusicsState with _$ClickRefreshPage {
  factory ClickRefreshPage(int id) = _ClickRefreshPage;
}
