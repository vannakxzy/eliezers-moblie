part of 'testhome_bloc.dart';

class TesthomeEvent extends BaseEvent {}

@freezed
class SumX extends TesthomeEvent with _$SumX {
  factory SumX() = _SumX;
}

@freezed
class InitPage extends TesthomeEvent with _$InitPage {
  const factory InitPage() = _InitPage;
}
