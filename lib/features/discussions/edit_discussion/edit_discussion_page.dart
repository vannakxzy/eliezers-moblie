import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/helper/fuction.dart';
import '../../home/domain/entities/question_entity.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../app/base/page/base_page_bloc_state.dart';

import '../../../core/constants/constants.dart';
import '../../../core/helper/local_data/storge_local.dart';
import '../../../core/utils/widgets/custom_tag_card.dart';
import '../../post/bottomsheet/select_audience_buttomsheet.dart';
import '../../post/domain/entities/tag_entity.dart';
import '../../post/presentation/bottomsheet/question_info_dialog.dart';
import 'bloc/edit_discussion_bloc.dart';

@RoutePage()
class EditDiscussionPage extends StatefulWidget {
  const EditDiscussionPage({super.key, required this.question});
  final QuestionEntity question;
  @override
  State<EditDiscussionPage> createState() => _EditDiscussionPageState();
}

class _EditDiscussionPageState
    extends BasePageBlocState<EditDiscussionPage, EditDiscussionBloc> {
  FocusNode focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    focusNode.addListener(() {
      bloc.add(ListenerFocusNodeEvent(focusNode.hasFocus));
    });
    bloc.add(InitPageEvent(widget.question));
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(kPadding),
        borderSide: BorderSide(
          color: context.moonColors!.beerus,
        ));
    return BlocBuilder<EditDiscussionBloc, EditDiscussionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(t.common.edit),
            elevation: 3,
            shadowColor: Colors.black12,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(MoonIcons.controls_close_24_regular),
            ),
            leadingWidth: kAppbarLeadingwidth,
            actions: [
              MoonButton.icon(
                onTap: () {
                  QuestionInfoDialog.show(context);
                },
                icon: const Icon(MoonIcons.generic_info_24_light),
              ),
              MoonButton(
                buttonSize: MoonButtonSize.sm,
                borderRadius: BorderRadius.circular(kRadius2),
                backgroundColor: !state.isValidatePost
                    ? context.moonColors!.hit
                    : context.moonColors!.beerus,
                textColor: !state.isValidatePost
                    ? context.moonColors!.piccolo
                    : context.moonColors!.trunks,
                label: Text(t.common.save.toUpperCase()),
                onTap: () {
                  if (!state.isValidatePost) {
                    bloc.add(ClickUpdateQuestionEvent());
                  }
                },
              ),
              kPadding.gap
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: kScreenPadding,
                  margin: const EdgeInsets.only(bottom: kPadding),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "${LocalStorage.getStringValue(SharedPreferenceKeys.name)} . "),
                          kPadding.gap,
                          MoonTag(
                            onTap: () async {
                              String audience =
                                  await SelectAudienceButtomsheet.show(
                                      context, state.audience);
                              bloc.add(AuienceChanged(audience));
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
                                  : t.post.onlyme,
                              style: context.moonTypography!.body.text14
                                  .copyWith(
                                      color: context.moonColors!.piccolo,
                                      fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  kPadding.gap,
                                  TextFormField(
                                    controller: state.titleTextEditController,
                                    decoration: InputDecoration(
                                        focusedBorder: inputBorder,
                                        enabledBorder: inputBorder,
                                        isDense: true,
                                        hintText: t.post.addTitle,
                                        hintStyle: context
                                            .moonTypography!.body.text16
                                            .copyWith(
                                                fontWeight: FontWeight.w500)),
                                    maxLines: 2,
                                    minLines: 1,
                                    style: context.moonTypography!.body.text16
                                        .copyWith(fontWeight: FontWeight.w500),
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      bloc.add(TitleChangedEvent(value));
                                    },
                                  ),
                                  kPadding.gap,
                                  TextFormField(
                                    controller: state.descriptionTextController,
                                    maxLines: 20,
                                    minLines: 5,
                                    style: context.moonTypography!.body.text14
                                        .copyWith(fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        focusedBorder: inputBorder,
                                        enabledBorder: inputBorder,
                                        isDense: true,
                                        hintText: t.post.addTitle,
                                        hintStyle: context
                                            .moonTypography!.body.text16
                                            .copyWith(
                                                fontWeight: FontWeight.w500)),
                                    onChanged: (value) {
                                      bloc.add(DescriptionChangedEvent(value));
                                    },
                                  ),
                                ],
                              ),
                              kPadding2.gap,
                              const AppDivider.normal(),
                              kPadding.gap,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    minLines: 1,
                                    style: context.moonTypography!.body.text14
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: context.moonColors!.trunks),
                                    readOnly: state.selectTags.length == 3
                                        ? true
                                        : false,
                                    focusNode: focusNode,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintStyle:
                                          context.moonTypography!.body.text14,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      hintText: state.selectTags.length == 3
                                          ? t.post.limitTag
                                          : "${t.post.addTag} *",
                                    ),
                                    controller: state.tagTextController,
                                    onChanged: (value) {
                                      _debounce?.cancel();

                                      _debounce = Timer(
                                          const Duration(milliseconds: 500),
                                          () {
                                        bloc.add(TagChangedEvent(value));
                                      });
                                    },
                                  ),
                                  if (state.selectTags.isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: kPadding, bottom: kPadding),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: kPadding,
                                        runSpacing: kPadding,
                                        children: [
                                          ...bloc.state.selectTags
                                              .asMap()
                                              .entries
                                              .map(
                                            (element) {
                                              return CustomTagCard(
                                                  isOnSearch: false,
                                                  title: element.value.name,
                                                  ontap: () {
                                                    bloc.add(
                                                        ClickRemoveTagEvent(
                                                            element.key));
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              kPadding.gap,
                              const AppDivider.normal(),
                              kPadding.gap,
                              if (state.image == null && state.urlImage.isEmpty)
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          bloc.add(PickImageGalleryEvent());
                                        },
                                        child: Icon(
                                            MoonIcons
                                                .generic_picture_24_regular,
                                            color: context.moonColors!.trunks)),
                                    GestureDetector(
                                        onTap: () {
                                          bloc.add(PickImageCameraEvent());
                                        },
                                        child: Icon(
                                            MoonIcons.media_photo_32_regular,
                                            color: context.moonColors!.trunks)),
                                  ],
                                ),
                              kPadding.gap,
                              if (state.image != null ||
                                  state.urlImage.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    bloc.add(PickImageGalleryEvent());
                                  },
                                  child: Stack(
                                    children: [
                                      state.urlImage.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: state.urlImage)
                                          : Image.file(state.image!,
                                              fit: BoxFit.cover),
                                      Positioned(
                                          top: kPadding,
                                          right: kPadding,
                                          child: Row(
                                            children: [
                                              if (state.urlImage.isEmpty)
                                                MoonButton.icon(
                                                  onTap: () {
                                                    bloc.add(ClickCropEvent());
                                                  },
                                                  buttonSize: MoonButtonSize.xs,
                                                  backgroundColor:
                                                      Colors.black87,
                                                  icon: const Icon(
                                                    Icons.crop,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              kPadding.gap,
                                              MoonButton.icon(
                                                  onTap: () {
                                                    bloc.add(
                                                        ClickClearImageEvent());
                                                  },
                                                  buttonSize: MoonButtonSize.xs,
                                                  backgroundColor:
                                                      Colors.black87,
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: state.tag != null &&
                        state.tagtext != '' &&
                        state.isFocus == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: kPadding / 2, horizontal: kPadding),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 0.5,
                                    color: context.moonColors!.trunks))),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: state.tag!.asMap().entries.map((e) {
                                  return CustomTagCard(
                                    isTheSame: e.value.name.trim() ==
                                            state.tagtext.trim()
                                        ? true
                                        : false,
                                    title: e.value.name,
                                    ontap: () {
                                      bloc.add(ClickSelectTagEvent(
                                        TagEntity(
                                            id: e.value.id, name: e.value.name),
                                      ));
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            if (!state.tag!.any((element) =>
                                    element.name == state.tagtext) &&
                                !state.selectTags.any(
                                    (element) => element.name == state.tagtext))
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.tagtext.length > 20
                                          ? t.post.tagOver
                                          : state.tagtext.length < 3
                                              ? t.post.tagLess
                                              : t.post.createTag,
                                      style: context.moonTypography!.body.text12
                                          .copyWith(
                                              color:
                                                  context.moonColors!.trunks),
                                    ),
                                  ),
                                  if (state.tagtext.length.isBetween(2, 21))
                                    MoonButton(
                                        padding: const EdgeInsets.all(4),
                                        onTap: () {
                                          bloc.add(ClickCreateTagEvent(
                                              state.tagtext));
                                        },
                                        label: state.isLoadingCreateTag
                                            ? MoonCircularLoader(
                                                sizeValue: 20,
                                                color:
                                                    context.moonColors!.piccolo,
                                              )
                                            : Text(t.common.yes,
                                                style: context
                                                    .moonTypography!.body.text14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColor
                                                            .primaryColor))),
                                ],
                              )
                          ],
                        ),
                      )
                    : null,
              )
            ],
          ),
        );
      },
    );
  }
}
