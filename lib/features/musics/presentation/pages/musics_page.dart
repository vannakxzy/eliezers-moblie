import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/bloc.dart';
import '../widgets/musics_card.dart';

@RoutePage()
class MusicsPage extends StatefulWidget {
  const MusicsPage({super.key});

  @override
  State<MusicsPage> createState() => _MusicsPageState();
}

class _MusicsPageState extends BasePageBlocState<MusicsPage, MusicsBloc> {
  @override
  void initState() {
    bloc.add(InitPage(1));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MusicsBloc, MusicState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                Row(children: [
                  kPadding.gap,
                  Text(t.music.title,
                      style: context.moonTypography!.heading.text20),
                  Spacer(),
                  // MoonButton(
                  //   leading: Icon(MoonIcons.generic_search_24_regular),
                  //   onTap: () {
                  //     appRoute.push(AppRouteInfo.resultSearch('', 2));
                  //   },
                  // ),
                  MoonButton(
                    onTap: () {
                      // bloc.add(ClickCreateband());
                    },
                    leading: Icon(
                      MoonIcons.generic_search_24_regular,
                    ),
                  ),
                  MoonButton(
                      onTap: () {
                        appRoute.push(AppRouteInfo.createMusic());
                      },
                      leading: Icon(
                        MoonIcons.controls_plus_24_regular,
                      )),
                ]),
                MoonFormTextInput(
                  borderRadius: BorderRadius.circular(20),
                  controller: TextEditingController(),
                  // validator: (String? value) =>
                  //     value != null && value.length < 5
                  //         ? "The text should be longer than 5 characters."
                  //         : null,
                  hintText: "sdfsfdsfdsdf",
                  // onTap: () => _textController.clear(),
                  leading: const Icon(MoonIcons.generic_search_24_light),
                  trailing: GestureDetector(
                    child: const Icon(MoonIcons.controls_close_small_24_light),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: state.isloading && state.musics.isEmpty
                        ? Center(
                            //  child: MoonC,
                            child: CircularProgressIndicator(),
                          )
                        : state.musics.isEmpty
                            ? const Center(child: SizedBox())
                            : AppSmartRefreshScrollView(
                                enableLoadMore: state.isMorePage,
                                onLoadMore: () async =>
                                    bloc.add(InitPage(state.page)),
                                onRefresh: () async {
                                  bloc.add(ClickRefreshPage(1));
                                },
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final musics = state.musics[index];
                                      return MusicsCard(
                                        entity: musics,
                                        ontap: () {
                                          bloc.add(ClickMusics(index));
                                        },
                                        clickFavorite: () {
                                          bloc.add(ClickFavorite(index));
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Gap(kPadding),
                                    itemCount: state.musics.length),
                              ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
