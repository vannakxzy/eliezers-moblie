import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/widgets/custom_tag_card.dart';
import '../bloc/bloc/bloc/result_tag_bloc.dart';
import '../../../../../gen/i18n/translations.g.dart';
import '../../../../../shared/widgets/app_refresh_indicator.dart';
import 'package:moon_design/moon_design.dart';

import '../widgets/tags_simmer_widget.dart';

class ResultTagPage extends StatefulWidget {
  String text;
  ResultTagPage({super.key, this.text = ''});

  @override
  State<ResultTagPage> createState() => _ResultTagPageState();
}

class _ResultTagPageState
    extends BasePageBlocState<ResultTagPage, ResultTagBloc> {
  @override
  bool get wantKeepAlive => true; // Enable keep-alive for this screen.
  @override
  void initState() {
    bloc.add(GetTags(widget.text));

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ResultTagBloc, ResultTagState>(
      builder: (context, state) {
        if (state.isloading &&
            state.tags.isEmpty &&
            state.recentSearch.isEmpty) {
          return SingleChildScrollView(child: TagsSimmerWidget());
        }
        // if (state.tags.isEmpty) {
        //   return const Center(child: CustomEmptyData());
        // }
        return AppSmartRefreshScrollView(
          enableLoadMore: state.isMorePage,
          onLoadMore: () async {
            bloc.add(GetTags(widget.text));
          },
          onRefresh: () async {
            bloc.add(RefreshPageP(widget.text));
          },
          child: widget.text == ""
              ? Column(
                  children: [
                    if (state.recentSearch.isNotEmpty)
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 4),
                          color: context.moonColors!.gohan,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.common.recentSearch,
                                style: context.moonTypography!.body.text14
                                    .copyWith(
                                        color: context.moonColors!.trunks),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bloc.add(RemoveAll());
                                },
                                child: Text(
                                  t.common.delete,
                                  style: context.moonTypography!.body.text14
                                      .copyWith(
                                          color: context.moonColors!.trunks),
                                ),
                              ),
                            ],
                          )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(kPadding),
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: state.recentSearch.length,
                          itemBuilder: (context, index) {
                            final tags = state.recentSearch[index];
                            return Dismissible(
                                background: Container(
                                    color: context.moonColors!.jiren,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      t.common.delete,
                                      style: context.moonTypography!.body.text14
                                          .copyWith(color: Colors.white),
                                    )),
                                key: Key("$tags"),
                                direction: DismissDirection
                                    .endToStart, // 👈 Only allow swipe left
                                onDismissed: (direction) {
                                  bloc.add(RemoveIndex(index));
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    bloc.add(ClickTag(tags));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(kPadding),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(kRadius2),
                                        border: Border.all(
                                          color: context.moonColors!.beerus,
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IgnorePointer(
                                            child: CustomTagCard(
                                                title: tags.name)),
                                        kPadding.gap,
                                        Text(
                                          "${tags.question_tags_count} ${t.common.question}",
                                          style: context
                                              .moonTypography!.body.text12
                                              .copyWith(
                                                  color: context
                                                      .moonColors!.trunks),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) =>
                              const Gap(kPadding),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(kPadding),
                  child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) => const Gap(kPadding),
                      itemCount: state.tags.length,
                      itemBuilder: (context, index) {
                        {
                          final tags = state.tags[index];
                          return GestureDetector(
                            onTap: () {
                              bloc.add(ClickTag(tags));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(kPadding),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(kRadius2),
                                  border: Border.all(
                                    color: context.moonColors!.beerus,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IgnorePointer(
                                      child: CustomTagCard(title: tags.name)),
                                  kPadding.gap,
                                  Text(
                                    "${tags.question_tags_count} ${t.common.question}",
                                    style: context.moonTypography!.body.text12
                                        .copyWith(
                                            color: context.moonColors!.trunks),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),
        );
      },
    );
  }
}
