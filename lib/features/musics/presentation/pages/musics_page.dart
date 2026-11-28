
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
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
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    bloc.add(InitPage(1));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch(bool isVisible) {
    if (!isVisible) {
      _searchController.clear();
    }

    bloc.add(ClickSearch(isVisible ? _searchController.text : ""));
  }

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: KDecoration,
      child: SafeArea(
        child: BlocBuilder<MusicsBloc, MusicState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      Text(
                        t.music.title,
                        style: context.moonTypography!.heading.text20,
                      ),
                      const Spacer(),
                      MoonButton(
                        onTap: () {
                          _toggleSearch(!state.isShowSearch);
                        },
                        leading: Icon(
                          state.isShowSearch
                              ? MoonIcons.controls_close_small_24_light
                              : MoonIcons.generic_search_24_regular,
                        ),
                      ),
                      MoonButton(
                        onTap: () {
                          appRoute.push(AppRouteInfo.createMusic());
                        },
                        leading: const Icon(
                          MoonIcons.controls_plus_24_regular,
                        ),
                      ),
                    ],
                  ),

                  // Animated Search
                  AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    alignment: Alignment.topCenter,
                    child: state.isShowSearch
                        ? TweenAnimationBuilder<double>(
                            key: const ValueKey('music-search'),
                            tween: Tween(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, -10 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  // top: 8,
                                  // bottom: 8,
                                  ),
                              child: MoonFormTextInput(
                                borderRadius: BorderRadius.circular(20),
                                controller: _searchController,
                                hintText: 'Search music...',
                                leading: const Icon(
                                  MoonIcons.generic_search_24_light,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    bloc.add(ClickSearch(""));
                                  },
                                  child: const Icon(
                                    MoonIcons.controls_close_small_24_light,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),

                  const Gap(kPadding),

                  // Music List
                  Expanded(
                    child: _buildMusicList(state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMusicList(MusicState state) {
    if (state.isloading && state.musics.isEmpty) {
      return ListView.builder(
        padding: EdgeInsets.only(bottom: kPadding),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kPadding),
            child: MoonMenuItem(
              height: 70,
              menuItemPadding: EdgeInsets.all(kPadding),
              borderRadius: BorderRadius.circular(kRadius),
              backgroundColor: context.moonColors!.beerus,
              label: const Text(''),
            ),
          );
        },
      );
    }

    if (state.musics.isEmpty) {
      return const Center(
        child: Text('No music found'),
      );
    }

    return AppSmartRefreshScrollView(
      enableLoadMore: state.isMorePage,
      onLoadMore: () async {
        bloc.add(InitPage(state.page));
      },
      onRefresh: () async {
        bloc.add(ClickRefreshPage(1));
      },
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: kPadding),
        shrinkWrap: false,
        primary: false,
        physics: const ClampingScrollPhysics(),
        itemCount: state.musics.length,
        separatorBuilder: (context, index) {
          return const Gap(kPadding);
        },
        itemBuilder: (context, index) {
          final music = state.musics[index];

          return MusicsCard(
            entity: music,
            ontap: () {
              bloc.add(ClickMusics(index));
            },
            clickFavorite: () {
              bloc.add(ClickFavorite(index));
            },
          );
        },
      ),
    );
  }
}
