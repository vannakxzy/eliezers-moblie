part of 'band_permissions_bloc.dart';

@freezed
class bandPermissionsState extends BaseState with _$bandPermissionsState {
  const factory bandPermissionsState.initial({
    @Default(bandPermissionEntity()) bandPermissionEntity permission,
    @Default(bandPermissionEntity()) bandPermissionEntity permissionUpdated,
    @Default(bandPermissionEntity()) bandPermissionEntity oldPermission,
    @Default(false) bool isUpdate,
  }) = _Initial;
}
