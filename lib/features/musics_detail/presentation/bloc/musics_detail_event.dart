part of 'musics_detail_bloc.dart';

class MusicsDetailEvent extends BaseEvent {}

@freezed
class InitPage extends MusicsDetailEvent with _$InitPage {
  const factory InitPage(MusicsEntity musics) = _InitPage;
}

@freezed
class ClickDownload extends MusicsDetailEvent with _$ClickDownload {
  const factory ClickDownload() = _ClickDownload;
}

@freezed
class ClickShare extends MusicsDetailEvent with _$ClickShare {
  factory ClickShare() = _ClickShare;
}

@freezed
class ClickFavorite extends MusicsDetailEvent with _$ClickFavorite {
  factory ClickFavorite() = _ClickFavorite;
}
