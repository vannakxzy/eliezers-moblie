part of 'home_bloc.dart';

class HomeEvent extends BaseEvent {}

@freezed
class InitPage extends HomeEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}
