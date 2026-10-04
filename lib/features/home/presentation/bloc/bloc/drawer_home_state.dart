part of 'drawer_home_bloc.dart';

@freezed
class DrawerHomeState extends BaseState with _$DrawerHomeState {
  const factory DrawerHomeState({
    @Default('') String tagtext,
  }) = _Initial;
}
