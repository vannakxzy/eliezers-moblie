part of 'manage_band_bloc.dart';

class ManagebandEvent extends BaseEvent {}

@freezed
class InitPageEvent extends ManagebandEvent with _$InitPageEvent {
  factory InitPageEvent(BandEntity band) = _InitPage;
}

@freezed
class ClickPermission extends ManagebandEvent with _$ClickPermission {
  factory ClickPermission(BandEntity band) = _ClickPermission;
}

@freezed
class ClickMemberEvent extends ManagebandEvent with _$ClickMemberEvent {
  factory ClickMemberEvent(BandEntity band) = _ClickMamber;
}

@freezed
class ClickAdministartor extends ManagebandEvent with _$ClickAdministartor {
  factory ClickAdministartor(BandEntity band) = _ClickAdministartor;
}

@freezed
class ClickbandType extends ManagebandEvent with _$ClickbandType {
  factory ClickbandType(BandEntity band) = _ClickbandType;
}

@freezed
class ClickSave extends ManagebandEvent with _$ClickSave {
  factory ClickSave(int bandId) = _ClickSava;
}

@freezed
class bandTypeChanged extends ManagebandEvent with _$bandTypeChanged {
  factory bandTypeChanged(bool value) = _bandTypeChanged;
}

@freezed
class TitleChanged extends ManagebandEvent with _$TitleChanged {
  factory TitleChanged(String value) = _TitleChanged;
}

@freezed
class DesChanged extends ManagebandEvent with _$DesChanged {
  factory DesChanged(String value) = _DesChanged;
}

@freezed
class ClickPinkImage extends ManagebandEvent with _$ClickPinkImage {
  factory ClickPinkImage() = _ClickPinkImage;
}

@freezed
class ClickOutSidePickImage extends ManagebandEvent
    with _$ClickOutSidePickImage {
  factory ClickOutSidePickImage() = _ClickOutSidePickImage;
}

@freezed
class ClcikUpdateImage extends ManagebandEvent with _$ClcikUpdateImage {
  factory ClcikUpdateImage(File file) = _ClcikUpdateImage;
}

@freezed
class UpdatePermission extends ManagebandEvent with _$UpdatePermission {
  factory UpdatePermission(bandPermissionEntity permission) = _UpdatePermission;
}
