import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../../shared/widgets/app_refresh_indicator.dart';
import '../bloc/category_bloc.dart';

@RoutePage()
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends BasePageBlocState<CategoryPage, CategoryBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(GetCategoryEvent());
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Row(
                    children: [
                      Text(t.book.book,
                          style: context.moonTypography!.heading.text20),
                      const Spacer(),
                      MoonButton.icon(
                        onTap: () {
                          bloc.add(ClickCreateCategory());
                        },
                        icon: const Icon(MoonIcons.controls_plus_24_regular),
                      ),
                    ],
                  ),
                ),
                kPadding.gap,
                Expanded(
                  child: state.isloading && state.category.isEmpty
                      ? const Center(child: CustomLoading())
                      : AppSmartRefreshScrollView(
                          enableLoadMore: false,
                          onRefresh: () async {
                            bloc.add(GetCategoryEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final itemSpacing = kPadding;
                                final totalSpacing = itemSpacing * 2;
                                final itemWidth =
                                    (constraints.maxWidth - totalSpacing) / 3;
                                return ReorderableWrap(
                                  buildDraggableFeedback:
                                      (context, constraints, child) {
                                    return Material(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(kRadius),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                  controller: ScrollController(),
                                  spacing: kPadding,
                                  runSpacing: kPadding,
                                  needsLongPressDraggable: true,
                                  onReorder: (oldIndex, newIndex) {
                                    bloc.add(Reordered(oldIndex, newIndex));
                                  },
                                  children: state.category
                                      .asMap()
                                      .entries
                                      .map((data) {
                                    final category = state.category[data.key];
                                    return SizedBox(
                                      key: ObjectKey(category.id),
                                      width: itemWidth,
                                      height: itemWidth + itemWidth / 3.5,
                                      child: GestureDetector(
                                        onTap: () {
                                          appRoute.push(
                                              AppRouteInfo.categoryDetail(
                                                  index: data.key,
                                                  mybloc: bloc));
                                        },
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                context.moonColors!.beerus,
                                                context.moonColors!
                                                    .trunks, // Top-left color
                                              ],
                                              stops: [0.0, 1],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(kRadius),
                                            image: category.cover!.isEmpty
                                                ? null
                                                : DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            "${category.cover}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          child: Stack(
                                            children: [
                                              if (category.name!.isNotEmpty)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          left: 8,
                                                          right: 8),
                                                  color:
                                                      category.cover!.isNotEmpty
                                                          ? context
                                                              .moonColors!.bulma
                                                              .withOpacity(0.6)
                                                          : Colors.transparent,
                                                  width: double.infinity,
                                                  child: Text(
                                                    "${category.name}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .moonTypography!
                                                        .body
                                                        .text12
                                                        .copyWith(
                                                      color: context
                                                          .moonColors!.goku,
                                                    ),
                                                  ),
                                                ),
                                              Positioned(
                                                bottom: 8,
                                                right: 10,
                                                child: Container(
                                                  color:
                                                      category.cover!.isNotEmpty
                                                          ? context
                                                              .moonColors!.bulma
                                                              .withOpacity(0.6)
                                                          : Colors.transparent,
                                                  child: Text(
                                                    "${category.count}",
                                                    style: context
                                                        .moonTypography!
                                                        .heading
                                                        .text12
                                                        .copyWith(
                                                            color: context
                                                                .moonColors!
                                                                .goku),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
