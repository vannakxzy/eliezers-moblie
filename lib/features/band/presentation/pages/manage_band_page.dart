import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/band_entity.dart';
import '../../domain/entities/band_permission_entity.dart';
import '../bloc/bloc/manage_band_bloc.dart';

@RoutePage()
class ManagebandPage extends StatefulWidget {
  final BandEntity band;
  const ManagebandPage({super.key, required this.band});

  @override
  State<ManagebandPage> createState() => _ManagebandPageState();
}

class _ManagebandPageState
    extends BasePageBlocState<ManagebandPage, ManagebandBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.band));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(kPadding),
        borderSide: BorderSide(
          color: context.moonColors!.beerus,
        ));
    return BlocBuilder<ManagebandBloc, ManageBandState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(state.bandUpdated);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(t.band.manageCommmunity),
              actions: [
                MoonButton(
                  textColor: state.enableSave
                      ? context.moonColors!.piccolo
                      : context.moonColors!.beerus,
                  label: Text(t.common.save.toUpperCase()),
                  onTap: () {
                    bloc.add(ClickSave(state.band.id));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [
                    kPadding2.gap,
                    MoonDropdown(
                        contentPadding: EdgeInsets.zero,
                        maxWidth: 130, // ✅ already good — limits width
                        onTapOutside: () {
                          bloc.add(ClickOutSidePickImage());
                        },
                        show: state.showPickImage,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // optional alignment
                          children: [
                            MoonButton(
                              leading:
                                  Icon(MoonIcons.generic_picture_24_regular),
                              label: Text(t.common.gallery),
                              onTap: () async {
                                bloc.add(ClickOutSidePickImage());
                                File image = await pickImage();
                                bloc.add(ClcikUpdateImage(image));
                              },
                            ),
                            MoonButton(
                              leading: Icon(MoonIcons.media_photo_24_regular),
                              label: Text(t.common.camera),
                              onTap: () async {
                                bloc.add(ClickOutSidePickImage());
                                File image =
                                    await pickImage(source: ImageSource.camera);
                                bloc.add(ClcikUpdateImage(image));
                              },
                            ),
                          ],
                        ),
                        //
                        child: GestureDetector(
                          onTap: () {
                            bloc.add(ClickPinkImage());
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.bottomLeft,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: context.moonColors!.trunks),
                                image: state.image != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(state.image!))
                                    : state.band.cover != ""
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              state.band.cover,
                                            ),
                                          )
                                        : null),
                            child: Container(
                              color: context.moonColors!.bulma.withOpacity(0.8),
                              height: 25,
                              width: double.infinity,
                              child: Center(
                                child: Icon(MoonIcons.media_photo_32_regular,
                                    size: 22,
                                    color: context.moonColors!.trunks),
                              ),
                            ),
                          ),
                        )),
                    kPadding2.gap,
                    TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      controller: state.titleController,
                      decoration: InputDecoration(
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          isDense: true,
                          hintText: t.post.addTitle,
                          hintStyle: context.moonTypography!.body.text16
                              .copyWith(fontWeight: FontWeight.w500)),
                      maxLines: 2,
                      minLines: 1,
                      style: context.moonTypography!.heading.text16,
                      onChanged: (value) {
                        bloc.add(TitleChanged(value));
                      },
                    ),
                    kPadding.gap,
                    TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      controller: state.desController,
                      maxLines: 20,
                      minLines: 5,
                      style: context.moonTypography?.body.text14,
                      decoration: InputDecoration(
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        isDense: true,
                        hintStyle: context.moonTypography?.body.text14,
                        border: InputBorder.none,
                        hintText: t.post.addDescription,
                      ),
                      onChanged: (value) {
                        bloc.add(DesChanged(value));
                      },
                    ),
                    kPadding2.gap,
                    MoonMenuItem(
                      onTap: () async {
                        // String audience =
                        //     await SelectAudiencebandButtomsheet.show(
                        //         context, "");
                        // bloc.add(AuDientChangedEvent(audience));
                      },
                      leading: Icon(MoonIcons.software_sorting_24_light),
                      label: Text(t.band.communitType,
                          style: context.moonTypography!.body.text16),
                      trailing: Text(
                        state.band.isPublic
                            ? t.band.privateAudienceTitle
                            : t.band.publicAudienceTitle,
                        style: context.moonTypography!.body.text16
                            .copyWith(color: context.moonColors!.piccolo),
                      ),
                    ),
                    MoonMenuItem(
                      onTap: () async {
                        bandPermissionEntity permission = await appRoute.push(
                          AppRouteInfo.bandPermission(state.band),
                        ) as bandPermissionEntity;
                        bloc.add(UpdatePermission(permission));
                      },
                      leading: Icon(MoonIcons.security_key_24_light),
                      label: Text(t.band.permission,
                          style: context.moonTypography!.body.text16),
                      trailing: Text(
                        "${countTruePermissions(state.band.permission)}/6",
                        style: context.moonTypography!.body.text16
                            .copyWith(color: context.moonColors!.piccolo),
                      ),
                    ),
                    MoonMenuItem(
                      onTap: () {
                        // bloc.add(ClickAdministartor(state.band));
                      },
                      leading: Icon(MoonIcons.security_shield_secured_24_light),
                      label: Text(t.band.administoators,
                          style: context.moonTypography!.body.text16),
                      trailing: Text(
                        "${state.band.administoator}",
                        style: context.moonTypography!.body.text16
                            .copyWith(color: context.moonColors!.piccolo),
                      ),
                    ),
                    MoonMenuItem(
                      onTap: () {
                        bloc.add(ClickMemberEvent(state.band));
                      },
                      leading: Icon(MoonIcons.generic_users_24_light),
                      label: Text(t.common.member,
                          style: context.moonTypography!.body.text16),
                      trailing: Text(
                        "${state.band.member}",
                        style: context.moonTypography!.body.text16
                            .copyWith(color: context.moonColors!.piccolo),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
