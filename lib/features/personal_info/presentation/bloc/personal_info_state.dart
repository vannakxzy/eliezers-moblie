part of 'personal_info_bloc.dart';

@freezed
class PersonalInfoState extends BaseState with _$PersonalInfoState {
  const factory PersonalInfoState({
    File? pickedImage,
    @Default(false) bool loading,
    @Default([]) List<AvartaEntity> avatars,
    @Default(false) bool loadingAvatar,
    ProfileEntity? profileEntity,
    @Default('') String userNameCompea,
    @Default('') String emailCompea,
    TextEditingController? userNameTextEditingController,
    TextEditingController? emailTextEditingController,
    @Default(0) int validateUserName,
    @Default(0) int validateEmail,
  }) = _Initial;
}
