import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../data/data_sources/remotes/report_api_service.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../bloc/personal_info_bloc.dart';
import '../bottomsheet/check_email_bottonsheet.dart';
import '../bottomsheet/check_user_name_buttonsheet.dart';
import '../bottomsheet/select_avatar_bottomsheet.dart';
import '../../../verify_email/bottomsheet/verify_email_bottomsheet.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/utils/widgets/custom_back.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../apps/page/display_image_page.dart';
import '../../../setting/bottomsheet/avatar_tye_buttonsheet.dart';
import '../bloc/bloc.dart';
import '../widgets/info_textfield_widget.dart';

@RoutePage()
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState
    extends BasePageBlocState<PersonalInfoPage, PersonalInfoBloc> {
  @override
  void initState() {
    bloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBack(),
        title: Text(t.profileInfo.title),
        actions: [
          BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
            builder: (_, state) {
              if (!bloc.hasChanged) {
                return Padding(
                  padding: const EdgeInsets.only(right: kPadding),
                  child: GestureDetector(
                      onTap: () {
                        debugPrint("dfssdf");
                        bloc.add(ClickShareUser());
                      },
                      child: const Icon(MiconSend)),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(right: kPadding),
                child: MoonTextButton(
                  onTap: () {
                    bloc.add(ClickUpdated());
                  },
                  buttonSize: MoonButtonSize.sm,
                  label: Text(t.common.save,
                      style: context.moonTypography!.body.text14.copyWith(
                          color: context.moonColors!.piccolo,
                          fontWeight: FontWeight.w500)),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        builder: (_, state) {
          if (state.loading) {
            return const Center(child: CustomLoading());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kPadding2),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                      color: context.moonColors?.beerus ?? Colors.grey,
                    )),
                    color: context.moonColors?.raditz10,
                  ),
                  child: _buildProfileImage(state),
                ),
                MoonTextButton(
                  onTap: () async {
                    final result = await PickImageType.showBottomSheet(context);
                    switch (result) {
                      case ImageType.avatar:
                        final avatar = await SelectAvatarBottomSheet.show(
                            context, state.profileEntity?.profile);
                        if (avatar != null) {
                          bloc.add(ClickSelectAvatarEvent(avatar));
                        }
                        break;
                      case ImageType.gallery:
                        final imagePicked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        final file = await cropProfile(File(imagePicked!.path));
                        bloc.add(SelectProfileImage(file));
                        break;
                      case ImageType.camera:
                        final imagePicked = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        final file = await cropProfile(File(imagePicked!.path));
                        bloc.add(SelectProfileImage(file));

                        break;
                      case null:
                        break;
                    }
                  },
                  label: Text(
                    t.profileInfo.editProfile,
                    style: context.moonTypography!.body.text14.copyWith(
                        color: context.moonColors!.piccolo,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(kPadding2),
                InfoTextFieldWidget(
                  enabled: true,
                  hintText: t.common.name,
                  controller: bloc.nameTextEditingController,
                  onChanged: (value) => bloc.add(
                    NameChangedEvent(value),
                  ),
                  leading: MoonIcons.generic_user_32_regular,
                ),
                const Gap(kPadding2),
                GestureDetector(
                  onTap: () async {
                    final text =
                        await CheckUserNameButtonsheet.show(context, bloc);
                    if (text == true) {
                      bloc.add(UserNameChangedEvent());
                    }
                  },
                  child: InfoTextFieldWidget(
                    enabled: false,
                    hintText: t.common.userName,
                    controller: state.userNameTextEditingController ??
                        TextEditingController(),
                    leading: MoonIcons.generic_mention_32_regular,
                  ),
                ),
                const Gap(kPadding2),
                GestureDetector(
                  onTap: () async {
                    final text =
                        await CheckEmailBottonsheet.show(context, bloc);
                    debugPrint("text $text");
                    if (text != '') {
                      final verify =
                          await VerifyEmailBottomsheet.show(context, text!);
                      debugPrint("verify $verify");
                      if (verify == true) {
                        bloc.add(EmailChangedEvent());
                      }
                    }
                  },
                  child: InfoTextFieldWidget(
                    enabled: false,
                    hintText: t.common.email,
                    controller: state.emailTextEditingController ??
                        TextEditingController(),
                    leading: MoonIcons.mail_envelope_32_regular,
                  ),
                ),
                const Gap(kPadding2),
                InfoTextFieldWidget(
                  hintText: t.common.introduceyourself,
                  controller: bloc.bioTextEditingController,
                  onChanged: (value) {
                    bloc.add(BioChangedEvent(value));
                  },
                  leading: MoonIcons.chat_comment_32_regular,
                ),
                const Gap(kPadding),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget? _buildProfileImage(PersonalInfoState state) {
    return state.pickedImage != null
        ? ClipOval(
            child: Image.file(state.pickedImage!, fit: BoxFit.cover),
          )
        : state.profileEntity?.profile.isNotEmptyOrNull == true
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayImagePage(
                          isYourImage: true,
                          tag: "3243242344",
                          report: ReportInput(user_id: state.profileEntity!.id),
                          imageUrl: state.profileEntity!.profile),
                    ),
                  );
                },
                child: Hero(
                  tag: state.profileEntity!.profile,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: state.profileEntity?.profile ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Center(
                        child: Icon(
                          MoonIcons.generic_user_16_light,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null;
  }
}
