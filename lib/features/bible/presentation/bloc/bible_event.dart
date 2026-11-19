part of 'bible_bloc.dart';

class BibleEvent extends BaseEvent {}

@freezed
class InitPage extends BibleEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}
