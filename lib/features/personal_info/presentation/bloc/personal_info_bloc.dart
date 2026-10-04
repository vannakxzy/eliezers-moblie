// ignore_for_file: void_checks

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../domain/usecase/check_email_usecase.dart';
import '../../domain/usecase/check_user_name_usecase.dart';
import '../../domain/usecase/update_personal_info_usecase.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/data_sources/remotes/personal_info_api_service.dart';
import '../../../create_account/domain/entities/avatar_entity.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/domain/usecase/get_profile_usecase.dart';

part 'personal_info_bloc.freezed.dart';
part 'personal_info_event.dart';
part 'personal_info_state.dart';

@Injectable()
class PersonalInfoBloc extends BaseBloc<PersonalInfoEvent, PersonalInfoState> {
  PersonalInfoBloc(
    this._updatePersonalInfoUsecase,
    this._checkEmailUseCase,
    this._checkUserNameUseCase,
    this._getProfileUsecase,
  ) : super(const _Initial()) {
    on<GetProfileEvent>(_getProfile);
    on<SelectProfileImage>(_onSelectProfileImage);
    on<NameChangedEvent>(_NameChangedEvent);
    on<BioChangedEvent>(_onBioChanged);
    on<UserNameChangedEvent>(_userNameChangedEvent);
    on<ClickSelectAvatarEvent>(_selectAvatar);
    on<ClickCheckUserNameEvent>(_checkUsername);
    on<ClickCheckEmail>(_checkEmail);
    on<EmailChangedEvent>(_emailChangedEvent);
    on<ClickUpdated>(_update);
    on<ClickShareUser>(_clickShareUser);
  }
  final UpdatePersonalInfoUsecase _updatePersonalInfoUsecase;
  final GetProfileUsecase _getProfileUsecase;
  final CheckEmailUseCase _checkEmailUseCase;
  final CheckUserNameUseCase _checkUserNameUseCase;

  final nameTextEditingController = TextEditingController();
  final userNameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final bioTextEditingController = TextEditingController();
  FutureOr<void> _clickShareUser(
      ClickShareUser event, Emitter<PersonalInfoState> emit) async {
    await shareUser(state.profileEntity!);
  }

  void _updateForm(Emitter<PersonalInfoState> emit) {
    final profile = state.profileEntity;
    if (profile == null) return;
    nameTextEditingController.text = profile.name;
    userNameTextEditingController.text = profile.username;
    emailTextEditingController.text = profile.email;
    bioTextEditingController.text = profile.bio;
    emit(state.copyWith(
        emailTextEditingController: TextEditingController(text: profile.email),
        userNameTextEditingController:
            TextEditingController(text: profile.username)));
  }

  ProfileEntity? _profile;
  void _updateProfileInfo() {
    _profile = state.profileEntity;
  }

  bool get hasChanged => _profile != state.profileEntity;

  FutureOr<void> _getProfile(
      GetProfileEvent event, Emitter<PersonalInfoState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loading: true));
        _profile = await _getProfileUsecase.excecute('');
        emit(state.copyWith(profileEntity: _profile, loading: false));
        _updateForm(emit);
      },
      onError: (error) async {
        emit(state.copyWith(loading: false));
      },
    );
  }

  FutureOr<void> _NameChangedEvent(
      NameChangedEvent event, Emitter<PersonalInfoState> emit) {
    final profileEtt = state.profileEntity ?? const ProfileEntity();
    emit(state.copyWith(profileEntity: profileEtt.copyWith(name: event.value)));
  }

  FutureOr<void> _selectAvatar(
      ClickSelectAvatarEvent event, Emitter<PersonalInfoState> emit) {
    emit(state.copyWith(
      profileEntity: state.profileEntity?.copyWith(profile: event.avatar ?? ""),
      pickedImage: null,
    ));
  }

  FutureOr<void> _checkEmail(
      ClickCheckEmail event, Emitter<PersonalInfoState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(validateEmail: 2, emailCompea: event.email));

      if (checkStringIsgmail(value: event.email)) {
        final email = await _checkEmailUseCase.excecute(event.email);
        emit(state.copyWith(
          validateEmail: email,
        ));
      }
    });
  }

  FutureOr<void> _checkUsername(
      ClickCheckUserNameEvent event, Emitter<PersonalInfoState> emit) async {
    await runAppCatching(() async {
      emit(state.copyWith(userNameCompea: event.userName));
      if (event.userName.length >= 6) {
        emit(state.copyWith(validateUserName: 2));
        final userName = await _checkUserNameUseCase.excecute(event.userName);
        emit(state.copyWith(
          validateUserName: userName,
        ));
      }
    });
  }

  FutureOr<void> _userNameChangedEvent(
      UserNameChangedEvent event, Emitter<PersonalInfoState> emit) {
    debugPrint("khmer sl mherer");
    final profileEtt = state.profileEntity ?? const ProfileEntity();
    emit(state.copyWith(
      userNameCompea: '',
      userNameTextEditingController:
          TextEditingController(text: state.userNameCompea),
      profileEntity: profileEtt.copyWith(
        username: state.userNameCompea,
      ),
    ));
  }

  FutureOr<void> _emailChangedEvent(
      EmailChangedEvent event, Emitter<PersonalInfoState> emit) {
    final profileEtt = state.profileEntity ?? const ProfileEntity();
    emit(state.copyWith(
      emailCompea: '',
      emailTextEditingController:
          TextEditingController(text: state.emailCompea),
      profileEntity: profileEtt.copyWith(
        email: state.emailCompea,
      ),
    ));
  }

  FutureOr<void> _onBioChanged(
      BioChangedEvent event, Emitter<PersonalInfoState> emit) {
    final profileEtt = state.profileEntity ?? const ProfileEntity();
    emit(state.copyWith(profileEntity: profileEtt.copyWith(bio: event.value)));
  }

  FutureOr<void> _update(
      ClickUpdated event, Emitter<PersonalInfoState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loading: true));
        final profile = await _updatePersonalInfoUsecase.excecute(
          UpdatePersonalInfoInput(
              bio: state.profileEntity?.bio,
              name: state.profileEntity?.name,
              username: state.profileEntity?.username,
              profile: state.profileEntity?.profile,
              email: state.profileEntity?.email),
        );
        emit(state.copyWith(loading: false));
        LocalStorage.storeData(
            key: SharedPreferenceKeys.name, value: profile.name);
        LocalStorage.storeData(
            key: SharedPreferenceKeys.avatar, value: profile.profile);
        _updateProfileInfo();
        appRoute.pop();
        appRoute.showSuccessSnackBar(t.profileInfo.udpateSuccessMessage);
      },
      onError: (error) async {
        appRoute.showErrorSnackBar(error.toString());
      },
    );
    // appRoute.pop();
  }

  FutureOr<void> _onSelectProfileImage(
      SelectProfileImage event, Emitter<PersonalInfoState> emit) async {
    String profile = await imageToBase64(event.imageFile);
    emit(state.copyWith(
      profileEntity: state.profileEntity?.copyWith(profile: profile),
      pickedImage: event.imageFile,
    ));
  }
}
