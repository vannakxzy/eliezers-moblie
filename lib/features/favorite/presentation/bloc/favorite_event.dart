part of 'favorite_bloc.dart';

class FavoriteEvent extends BaseEvent {}

@freezed
class InitPage extends FavoriteEvent with _$InitPage {
  factory InitPage() = _InitPage;
}
