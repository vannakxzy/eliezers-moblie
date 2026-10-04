import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../band/domain/entities/band_entity.dart';
import '../../bottomsheet/select_audience_buttomsheet.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../di/di.dart';
import '../../post_question/bloc/post_question_bloc.dart';
import '../bottomsheet/question_info_dialog.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_tag_card.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../domain/entities/tag_entity.dart';
import '../../post_topic/bloc/post_topic_bloc.dart';
import '../bloc/post_bloc.dart';

@RoutePage()
class PostQuestionPage extends StatefulWidget {
  final BandEntity band;

  const PostQuestionPage({super.key, required this.band});

  @override
  State<PostQuestionPage> createState() => _PostQuestionPageState();
}

class _PostQuestionPageState
    extends BasePageBlocState<PostQuestionPage, PostBloc> {
  FocusNode focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    bloc.add(InitPage());
    focusNode.addListener(() {
      bloc.add(ListenerFocusNodeEvent(focusNode.hasFocus));
    });
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
        borderRadius: BorderRadius.circular(kRadius2),
        borderSide: BorderSide(
          color: context.moonColors!.beerus,
        ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<PostQuestionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<PostTopicBloc>(),
        ),
      ],
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              unFocus();
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(t.post.createQuestion),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(MoonIcons.controls_close_24_regular),
                ),
                leadingWidth: kAppbarLeadingwidth,
                actions: [
                  kPadding.gap,
                  MoonButton(
                    buttonSize: MoonButtonSize.lg,
                    borderRadius: BorderRadius.circular(kRadius2),
                    textColor: !state.isValidatePost
                        ? context.moonColors!.piccolo
                        : context.moonColors!.trunks.withOpacity(0.6),
                    label: Text(t.common.create.toUpperCase()),
                    onTap: () {
                      if (!state.isValidatePost) {
                        bloc.add(ClickPostQuestionEvent(widget.band.id));
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
                          widget.band != BandEntity()
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${t.band.title} . "),
                                    kPadding.gap,
                                    MoonTag(
                                      borderRadius:
                                          BorderRadius.circular(kRadius2),
                                      backgroundColor: context.moonColors!.hit,
                                      label: Text(
                                        widget.band.name,
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                                color:
                                                    context.moonColors!.piccolo,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${LocalStorage.getStringValue(SharedPreferenceKeys.name)} :",
                                      style: context
                                          .moonTypography!.heading.text16,
                                    ),
                                    kPadding.gap,
                                    MoonTag(
                                      borderRadius:
                                          BorderRadius.circular(kRadius2),
                                      onTap: () async {
                                        String audience =
                                            await SelectAudienceButtomsheet
                                                .show(context, state.audience);
                                        bloc.add(AuDientChanged(audience));
                                      },
                                      leading: Icon(
                                        state.audience == "public"
                                            ? MoonIcons.generic_globe_24_regular
                                            : MoonIcons
                                                .security_lock_16_regular,
                                        color: context.moonColors!.piccolo,
                                        size: 20,
                                      ),
                                      backgroundColor: context
                                          .moonColors!.piccolo
                                          .withOpacity(0.2),
                                      label: Text(
                                        state.audience == "public"
                                            ? t.post.public
                                            : t.post.onlyme,
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                                color: context
                                                    .moonColors!.piccolo),
                                      ),
                                    ),
                                    Spacer(),
                                    MoonButton.icon(
                                      onTap: () {
                                        QuestionInfoDialog.show(context);
                                      },
                                      icon: const Icon(
                                          MoonIcons.generic_info_24_light),
                                    ),
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
                                        decoration: InputDecoration(
                                            focusedBorder: inputBorder,
                                            enabledBorder: inputBorder,
                                            isDense: true,
                                            hintText: t.post.addTitle,
                                            hintStyle: context
                                                .moonTypography!.body.text16),
                                        maxLines: 2,
                                        minLines: 1,
                                        style: context
                                            .moonTypography!.heading.text16,
                                        onChanged: (value) {
                                          bloc.add(TitleChangedEvent(value));
                                        },
                                      ),
                                      kPadding.gap,
                                      TextFormField(
                                        maxLines: 20,
                                        minLines: 5,
                                        style:
                                            context.moonTypography?.body.text14,
                                        decoration: InputDecoration(
                                          focusedBorder: inputBorder,
                                          enabledBorder: inputBorder,
                                          isDense: true,
                                          hintStyle: context
                                              .moonTypography?.body.text14,
                                          border: InputBorder.none,
                                          hintText: t.post.addDescription,
                                        ),
                                        onChanged: (value) {
                                          bloc.add(
                                              DescriptionChangedEvent(value));
                                        },
                                      ),
                                    ],
                                  ),
                                  kPadding2.gap,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        autofillHints: null,
                                        minLines: 1,
                                        style: context
                                            .moonTypography!.body.text14
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    context.moonColors!.trunks),
                                        readOnly: state.selectTags.length == 3
                                            ? true
                                            : false,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintStyle: context
                                              .moonTypography!.body.text14,
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
                                              Duration(milliseconds: 800), () {
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
                                  if (state.image == null)
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              bloc.add(PickImageGalleryEvent());
                                            },
                                            child: Icon(
                                              MoonIcons
                                                  .generic_picture_32_regular,
                                              color: context.moonColors!.trunks,
                                              size: 30,
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              bloc.add(PickImageCameraEvent());
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
                                        bloc.add(PickImageGalleryEvent());
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
                                                      bloc.add(
                                                          ClickCropEvent());
                                                    },
                                                    buttonSize:
                                                        MoonButtonSize.xs,
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
                                                    buttonSize:
                                                        MoonButtonSize.xs,
                                                    backgroundColor:
                                                        Colors.black87,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: state.tagtext != '' && state.isFocus == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPadding / 2, horizontal: kPadding),
                            decoration: BoxDecoration(
                                border: state.tagtext.length < 3 &&
                                            state.tag.isEmpty ||
                                        state.selectTags.any((element) =>
                                            element.name == state.tagtext)
                                    ? null
                                    : Border(
                                        top: BorderSide(
                                            width: 0.2,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary))),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children:
                                        state.tag.asMap().entries.map((e) {
                                      return CustomTagCard(
                                        isTheSame: e.value.name.trim() ==
                                                state.tagtext.trim()
                                            ? true
                                            : false,
                                        title: e.value.name,
                                        ontap: () {
                                          bloc.add(ClickSelectTagEvent(
                                            TagEntity(
                                                id: e.value.id,
                                                name: e.value.name),
                                          ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                if (!state.tag.any((element) =>
                                        element.name == state.tagtext) &&
                                    !state.selectTags.any((element) =>
                                        element.name == state.tagtext))
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.tagtext.length > 20
                                              ? t.post.tagOver
                                              : state.tagtext.length < 3
                                                  ? t.post.tagLess
                                                  : t.post.createTag,
                                          style: context
                                              .moonTypography!.body.text14
                                              .copyWith(
                                                  color: context
                                                      .moonColors!.trunks),
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
                                                    color: context
                                                        .moonColors!.piccolo,
                                                  )
                                                : Text(t.common.yes,
                                                    style: context
                                                        .moonTypography!
                                                        .body
                                                        .text14
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
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
            ),
          );
        },
      ),
    );
  }
}
