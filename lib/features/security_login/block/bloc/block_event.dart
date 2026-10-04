part of 'block_bloc.dart';

class BlockEvent extends BaseEvent {}

@freezed
class GetBlockEvent extends BlockEvent with _$GetBlockEvent {
  factory GetBlockEvent() = _GetBlockEvent;
}

@freezed
class ClickUnBlockEvent extends BlockEvent with _$ClickUnBlockEvent {
  factory ClickUnBlockEvent(int index) = _ClickUnBlockEvent;
}

@freezed
class RefreshPage extends BlockEvent with _$RefreshPage {
  factory RefreshPage() = _RefreshPage;
}
