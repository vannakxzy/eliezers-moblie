part of 'scaffold_with_navbar_bloc.dart';

@freezed
class ScaffoldWithNavbarState extends BaseState with _$ScaffoldWithNavbarState {
  factory ScaffoldWithNavbarState({
    @Default(true) bool isShowButton,
    @Default(false) bool isAnonymous,
  }) = _ScaffoldWithNavbarState;
}
