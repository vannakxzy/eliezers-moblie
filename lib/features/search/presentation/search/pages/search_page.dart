// ignore_for_file: unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/fuction.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/search_bloc.dart';

enum _Section { input, dropdown }

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BasePageBlocState<SearchPage, SearchBloc> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode.addListener(
      () {
        setState(() {
          _isForcus = focusNode.hasFocus;
          debugPrint("$_isForcus");
        });
      },
    );
    bloc.add(const InitialEvent());
    super.initState();
  }

  bool _isForcus = false;

  final _textEditingController = TextEditingController();

  @override
  Widget buildPage(BuildContext context) {
    BorderRadiusGeometry? getBorderRadius(_Section variant) {
      const double borderRadiusValue = 40;

      return _isForcus
          ? BorderRadius.vertical(
              top: Radius.circular(
                variant == _Section.input
                    ? borderRadiusValue
                    : borderRadiusValue,
              ),
              bottom: Radius.circular(
                variant == _Section.dropdown
                    ? borderRadiusValue
                    : borderRadiusValue,
              ),
            )
          : BorderRadius.circular(borderRadiusValue);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: false,
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () {
          unFocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (_, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kPadding2, right: kPadding2),
                      child: Row(
                        children: [
                          // CustomBack(),
                          kPadding.gap,
                          Expanded(
                            child: MoonTextInput(
                              backgroundColor:
                                  context.moonColors!.beerus.withOpacity(0.2),
                              padding: const EdgeInsets.only(left: kPadding2),
                              height: 40,
                              borderRadius: BorderRadius.circular(30),
                              focusNode: focusNode,
                              textInputSize: MoonTextInputSize.lg,
                              enabled: true,
                              activeBorderColor: context.moonColors!.beerus,
                              hasFloatingLabel: false,
                              hintText: t.search.title,
                              controller: _textEditingController,
                              onChanged: (value) {
                                bloc.add(
                                    TextSearchInputChanged(textSearch: value));
                              },
                              onSubmitted: (_) {
                                bloc.add(const ClickSearchEvent());
                              },
                              leading: !_isForcus
                                  ? const Icon(
                                      MoonIcons.generic_search_24_light)
                                  : null,
                              trailing: _textEditingController
                                          .text.isNotEmpty &&
                                      _isForcus
                                  ? Row(
                                      children: [
                                        MoonButton.icon(
                                          padding: EdgeInsets.zero,
                                          hoverEffectColor: Colors.transparent,
                                          onTap: () {
                                            bloc.add(
                                                const ClearTextSearchInput());
                                            _textEditingController.clear();
                                          },
                                          icon: Icon(
                                            MoonIcons.software_clear_16_light,
                                            color: context.moonColors!.trunks,
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                          if (_isForcus)
                            MoonTextButton(
                              label: Text(
                                t.common.cancel,
                                style: context.moonTypography!.body.text14
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              onTap: () {
                                appRoute.pop();
                                // unFocus();
                              },
                            )
                        ],
                      ),
                    ),
                    if (!_isForcus)
                      Expanded(
                        child: AppSmartRefreshScrollView(
                          onRefresh: () async {
                            bloc.add(const InitialEvent());
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kPadding.gap,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding2),
                                  child: Row(
                                    children: [
                                      Text(
                                        t.search.popularSearch,
                                        style:
                                            context.moonTypography?.body.text16,
                                      ),
                                      const Gap(kPadding / 2),
                                      const Icon(
                                          MoonIcons.arrows_boost_32_light)
                                    ],
                                  ),
                                ),
                                const Gap(kPadding),
                                BlocBuilder<SearchBloc, SearchState>(
                                  builder: (_, s) {
                                    if (s.popularSearch.isEmpty == true) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding2),
                                      child: Wrap(
                                        spacing: kPadding,
                                        runSpacing: kPadding,
                                        children: [
                                          ...(s.popularSearch.map(
                                            (e) => MoonChip(
                                              onTap: () {
                                                clickToSearch(e.title ?? '');
                                              },
                                              backgroundColor:
                                                  context.moonColors?.gohan,
                                              chipSize: MoonChipSize.md,
                                              label: Text(e.title!),
                                              leading: Icon(
                                                MoonIcons.generic_star_16_light,
                                                color:
                                                    context.moonColors?.krillin,
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const Gap(kPadding2),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (_isForcus)
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding2)
                                  .copyWith(top: kPadding),
                          itemCount: state.recentSearch.length,
                          separatorBuilder: (_, index) => const Gap(4),
                          itemBuilder: (_, index) {
                            final recentSearch = state.recentSearch[index];
                            return MoonMenuItem(
                              horizontalGap: kPadding,
                              onTap: () {
                                clickToSearch(recentSearch);
                              },
                              menuItemPadding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              leading: const Icon(MoonIcons.time_time_32_light),
                              label: Text(recentSearch),
                              trailing: MoonButton.icon(
                                onTap: () {
                                  bloc.add(
                                      ClickRemoveHistoryItem(index: index));
                                },
                                icon: const Icon(
                                    MoonIcons.controls_close_32_light),
                              ),
                            );
                          },
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void clickToSearch(String recentSearch) {
    bloc.add(ClickHistoryItem(text: recentSearch));
    _textEditingController.text = recentSearch;
  }
}
