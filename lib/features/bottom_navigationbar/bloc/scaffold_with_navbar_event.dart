part of 'scaffold_with_navbar_bloc.dart';

abstract class ScaffoldWithNavbarEvent extends BaseEvent {}

@freezed
class ScrollDirectionUpdateEvent extends ScaffoldWithNavbarEvent
    with _$ScrollDirectionUpdateEvent {
  factory ScrollDirectionUpdateEvent({
    required bool isScrollingDown,
  }) = _ScrollDirectionUpdateEvent;
}

@freezed
class PressedHomeButtonEvent extends ScaffoldWithNavbarEvent
    with _$PressedHomeButtonEvent {
  factory PressedHomeButtonEvent() = _PressedHomeButtonEvent;
}

@freezed
class PressSaveButtonEvent extends ScaffoldWithNavbarEvent
    with _$PressSaveButtonEvent {
  factory PressSaveButtonEvent() = _PressSaveButtonEvent;
}

@freezed
class PressProfileButtonEvent extends ScaffoldWithNavbarEvent
    with _$PressProfileButtonEvent {
  factory PressProfileButtonEvent() = _PressProfileButtonEvent;
}

@freezed
class MakeToAnonymousEvent extends ScaffoldWithNavbarEvent
    with _$MakeToAnonymousEvent {
  factory MakeToAnonymousEvent() = _MakeToAnonymousEvent;
}

@freezed
class ClickClearAnonymous extends ScaffoldWithNavbarEvent with _$ClickClearAnonymous {
  factory ClickClearAnonymous() = _ClickClearAnonymous;
}

@freezed
class ClickLeaveAnonymousEvent extends ScaffoldWithNavbarEvent with _$ClickLeaveAnonymousEvent {
  factory ClickLeaveAnonymousEvent() = _ClickLeaveAnonymousEvent;
}
