import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../../core/utils/widgets/custom_empty_data.dart';
import '../../../core/utils/widgets/custom_loading.dart';

import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import 'bloc/select_avtar_bloc.dart';

@RoutePage()
class SelectAvatarPage extends StatefulWidget {
  const SelectAvatarPage({super.key});

  @override
  State<SelectAvatarPage> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState
    extends BasePageBlocState<SelectAvatarPage, SelectAvatarBloc> {
  @override
  void initState() {
    bloc.add(GetAvatar());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: t.selectAvatar.title,
        ),
        body: SafeArea(
          child: BlocBuilder<SelectAvatarBloc, SelectAvatarState>(
            builder: (context, state) {
              return Container(
                padding: kScreenPadding,
                child: state.isLoadin && state.avatar.isEmpty
                    ? const Center(
                        child: CustomLoading(),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: state.avatar.isEmpty
                                ? const CustomEmptyData()
                                : Column(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          child: AppSmartRefreshScrollView(
                                            onRefresh: () async {
                                              bloc.add(GetAvatar());
                                            },
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: kPadding),
                                              mainAxisSpacing: kPadding,
                                              crossAxisSpacing: kPadding,
                                              crossAxisCount: 3,
                                              children: [
                                                ...state.avatar.asMap().entries.map(
                                                    (e) => GestureDetector(
                                                          onTap: () {
                                                            bloc.add(
                                                                ClickAvatar(
                                                                    e.key));
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.all(
                                                                state.selectedIndex !=
                                                                        e.key
                                                                    ? 10
                                                                    : 0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                              color: state.selectedIndex ==
                                                                      e.key
                                                                  ? AppColor
                                                                      .primaryColor
                                                                  : Colors
                                                                      .transparent,
                                                            )),
                                                            child:
                                                                CachedNetworkImage(
                                                                    imageUrl: e
                                                                        .value
                                                                        .name),
                                                          ),
                                                        )

                                                    //  MoonButton(
                                                    //   borderWidth: 3,
                                                    // borderColor:
                                                    //     state.selectedIndex == e.key
                                                    //         ? context.moonColors!.piccolo
                                                    //         : Colors.transparent,
                                                    //   showBorder: true,
                                                    //   borderRadius: BorderRadius.zero,
                                                    //   buttonSize: MoonButtonSize.md,
                                                    //   onTap: () {
                                                    //     bloc.add(ClickAvatar(e.key));
                                                    //   },
                                                    //   padding: state.selectedIndex ==
                                                    //           e.key
                                                    //       ? const EdgeInsets.all(0)
                                                    //       : EdgeInsets.zero,
                                                    //   backgroundColor:
                                                    //       Colors.transparent,
                                                    //   label: CachedNetworkImage(
                                                    //       imageUrl: e.value.name),
                                                    // ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                          // child: Wrap(
                                          //     crossAxisAlignment:
                                          //         WrapCrossAlignment.center,
                                          //     alignment: WrapAlignment.center,
                                          //     children: [
                                          //       ...List.generate(
                                          //         state.avatar.length,
                                          //         (index) => GestureDetector(
                                          //           onTap: () {
                                          //             bloc.add(ClickAvatar(index));
                                          //           },
                                          //           child: Container(
                                          //             margin: const EdgeInsets.all(4),
                                          //             height: MediaQuery.sizeOf(context)
                                          //                     .width /
                                          //                 5,
                                          //             width: MediaQuery.sizeOf(context)
                                          //                     .width /
                                          //                 5,
                                          //             decoration: BoxDecoration(
                                          //                 border: Border.all(
                                          //                     color: const Color.fromARGB(
                                          //                         255, 255, 94, 112),
                                          //                     width: index ==
                                          //                             state.selectedIndex
                                          //                         ? 3
                                          //                         : 0),
                                          //                 image: DecorationImage(
                                          //                   image:
                                          //                       CachedNetworkImageProvider(
                                          //                     state.avatar[index].name,
                                          //                   ),
                                          //                 )),
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ]),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MoonTextButton(
                                  onTap: () {
                                    bloc.add(ClickSkipEvent());
                                  },
                                  label: Text(t.common.skip),
                                ),
                              ),
                              Expanded(
                                child: CustomButtom(
                                  isFullWidth: true,
                                  title: t.common.ok,
                                  onTap: () {
                                    bloc.add(ClickConfirmEvent());
                                  },
                                  trailing: state.submitLoading
                                      ? const MoonCircularLoader(
                                          sizeValue: 20,
                                          color: Colors.white,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              );
            },
          ),
        ));
  }
}
