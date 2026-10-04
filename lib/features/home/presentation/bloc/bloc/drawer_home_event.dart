part of 'drawer_home_bloc.dart';

abstract class DrawerHomeEvent extends BaseEvent {}

@freezed
class ClickHome extends DrawerHomeEvent with _$ClickHome {
  factory ClickHome() = _ClickHome;
}

@freezed
class ClickDiscussions extends DrawerHomeEvent with _$ClickDiscussions {
  factory ClickDiscussions() = _ClickDiscussions;
}

@freezed
class ClickUser extends DrawerHomeEvent with _$ClickUser {
  factory ClickUser() = _ClickUser;
}

@freezed
class ClickBooks extends DrawerHomeEvent with _$ClickBooks {
  factory ClickBooks() = _ClickBooks;
}

@freezed
class ClickTags extends DrawerHomeEvent with _$ClickTags {
  factory ClickTags() = _ClickTags;
}
