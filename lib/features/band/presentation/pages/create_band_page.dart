import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../buttomsheet/select_audience_band_buttomsheet.dart';
import '../bloc/bloc/create_band_bloc.dart';

@RoutePage()
class CreatebandPage extends StatefulWidget {
  const CreatebandPage({super.key});

  @override
  State<CreatebandPage> createState() => _bandPageState();
}

class _bandPageState extends BasePageBlocState<CreatebandPage, CreatebandBloc> {
  @override
  void initState() {
    bloc.add(InitPage());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(kPadding),
        borderSide: BorderSide(
          color: context.moonColors!.beerus,
        ));
    return BlocBuilder<CreatebandBloc, CreateBandState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: CloseButton(),
            title: Text(t.band.createband),
            actions: [
              MoonButton(
                onTap: () {
                  bloc.add(ClickCreatebandEvent());
                },
                label: Text(
                  t.common.create,
                  style: context.moonTypography!.heading.text16.copyWith(
                      color: state.enableButton
                          ? context.moonColors!.piccolo
                          : context.moonColors!.beerus),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${t.band.title} . "),
                    kPadding.gap,
                    MoonTag(
                      onTap: () async {
                        String audience =
                            await SelectAudiencebandButtomsheet.show(
                                context, state.audience);
                        bloc.add(AuDientChangedEvent(audience));
                      },
                      leading: Icon(
                        state.audience == "public"
                            ? MoonIcons.generic_globe_24_regular
                            : MoonIcons.security_lock_16_regular,
                        color: context.moonColors!.piccolo,
                        size: 20,
                      ),
                      backgroundColor: context.moonColors!.hit,
                      label: Text(
                        state.audience == "public"
                            ? t.post.public
                            : t.band.privateAudienceTitle,
                        style: context.moonTypography!.body.text14.copyWith(
                            color: context.moonColors!.piccolo,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                kPadding.gap,
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      isDense: true,
                      hintText: t.common.name,
                      hintStyle: context.moonTypography!.body.text16
                          .copyWith(fontWeight: FontWeight.w500)),
                  maxLines: 2,
                  minLines: 1,
                  style: context.moonTypography!.heading.text16,
                  onChanged: (value) {
                    bloc.add(NameChanged(value));
                  },
                ),
                kPadding.gap,
                TextFormField(
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
                kPadding.gap,
                if (state.image == null)
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            bloc.add(ClickPickImageGallery());
                          },
                          child: Icon(
                            MoonIcons.generic_picture_32_regular,
                            color: context.moonColors!.trunks,
                            size: 30,
                          )),
                      GestureDetector(
                          onTap: () {
                            bloc.add(ClickPickImageCamera());
                          },
                          child: Icon(
                            MoonIcons.media_photo_32_regular,
                            color: context.moonColors!.trunks,
                            size: 30,
                          )),
                    ],
                  ),
                kPadding.gap,
                if (state.image != null)
                  GestureDetector(
                    onTap: () {
                      bloc.add(ClickPickImageGallery());
                    },
                    child: Stack(
                      children: [
                        Image.file(
                          state.image!,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: kPadding,
                            right: kPadding,
                            child: Row(
                              children: [
                                MoonButton.icon(
                                  onTap: () {
                                    bloc.add(ClickCrop());
                                  },
                                  buttonSize: MoonButtonSize.xs,
                                  backgroundColor: Colors.black87,
                                  icon: const Icon(
                                    Icons.crop,
                                    color: Colors.white,
                                  ),
                                ),
                                kPadding.gap,
                                MoonButton.icon(
                                  onTap: () {
                                    bloc.add(ClickClearImage());
                                  },
                                  buttonSize: MoonButtonSize.xs,
                                  backgroundColor: Colors.black87,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
