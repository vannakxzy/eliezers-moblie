import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../../core/utils/widgets/custom_tag_card.dart';
import '../../../data/models/filter_entity.dart';
import '../../../shared/widgets/app_divider.dart';
import '../presentation/bloc/bloc/filter_widget_buttomsheet_bloc.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget._({this.filter});
  final FilterEntity? filter;

  static Future<FilterEntity?> show(BuildContext context,
          [FilterEntity? filter]) =>
      showMoonModalBottomSheet(
        context: context,
        builder: (_) => FilterWidget._(
          filter: filter,
        ),
      );

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState
    extends BasePageBlocState<FilterWidget, FilterWidgetButtomsheetBloc> {
  Timer? _debounce;
  @override
  void initState() {
    bloc.add(InitPage(widget.filter!));
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<FilterWidgetButtomsheetBloc,
        FilterWidgetButtomsheetState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: t.filter.title,
            isClose: true,
            action: MoonButton.icon(
              onTap: () {
                bloc.add(ClearFilter());
              },
              icon: Icon(
                MoonIcons.travel_airplane_24_regular,
                color: state.filter.activeFilterCount > 0
                    ? context.moonColors!.piccolo
                    : context.moonColors!.beerus,
              ),
            ),
          ),
          body: BlocBuilder<FilterWidgetButtomsheetBloc,
              FilterWidgetButtomsheetState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(kPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.common.tag,
                                style: context.moonTypography!.heading.text16,
                              ),
                              kPadding.gap,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: kPadding,
                                    runSpacing: kPadding,
                                    children: [
                                      ...List.generate(
                                        state.filter.tag.length,
                                        (index) {
                                          final tag = state.filter.tag[index];
                                          return CustomTagCard(
                                            title: tag.name,
                                            isOnSearch: false,
                                            ontap: () {
                                              bloc.add(ClearTag(index));
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  MoonTextInput(
                                    leading:
                                        Icon(MoonIcons.generic_search_24_light),
                                    padding: EdgeInsets.zero,
                                    controller: state.searchText,
                                    decoration: BoxDecoration(),
                                    hintText: t.common.tag,
                                    onChanged: (value) {
                                      debugPrint("jjjjjjjjjjjjjjj");
                                      _debounce?.cancel();
                                      _debounce = Timer(
                                          Duration(milliseconds: 500), () {
                                        debugPrint("sdfsdfsdf");
                                        bloc.add(SearchTag(value));
                                      });
                                    },
                                  ),
                                  AppDivider.large()
                                ],
                              ),
                              kPadding2.gap,
                              Text(
                                t.common.type,
                                style: context.moonTypography!.heading.text16,
                              ),
                              kPadding.gap,
                              Wrap(
                                spacing: kPadding,
                                runSpacing: kPadding,
                                children: type.entries.map((entry) {
                                  final key = entry.key;
                                  final value = entry.value;
                                  return MoonTag(
                                    onTap: () {
                                      bloc.add(ClickType(
                                          key)); // Send key instead of index
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: state.filter.type == key
                                          ? context.moonColors!.piccolo
                                              .withOpacity(0.3)
                                          : context.moonColors!.beerus
                                              .withOpacity(0.5),
                                    ),
                                    label: Text(
                                      value,
                                      style: context.moonTypography!.body.text12
                                          .copyWith(
                                        color: state.filter.type == key
                                            ? context.moonColors!.piccolo
                                            : context.moonColors!.trunks,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              kPadding2.gap,
                              Text(
                                t.filter.status,
                                style: context.moonTypography!.heading.text16,
                              ),
                              kPadding.gap,
                              Wrap(
                                spacing: kPadding,
                                runSpacing: kPadding,
                                children: status.entries.map((entry) {
                                  final key = entry.key;
                                  final value = entry.value;

                                  return MoonTag(
                                    onTap: () {
                                      bloc.add(ClickStatus(
                                          key)); // send key instead of index
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: state.filter.status == key
                                          ? context.moonColors!.piccolo
                                              .withOpacity(0.2)
                                          : context.moonColors!.beerus
                                              .withOpacity(0.5),
                                    ),
                                    label: Text(
                                      value,
                                      style: context.moonTypography!.body.text12
                                          .copyWith(
                                        color: state.filter.status == key
                                            ? context.moonColors!.piccolo
                                            : context.moonColors!.trunks,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              kPadding2.gap,
                              Text(
                                t.filter.like,
                                style: context.moonTypography!.heading.text16,
                              ),
                              kPadding.gap,
                              Wrap(
                                spacing: kPadding,
                                runSpacing: kPadding,
                                children: like.entries
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  // final index = entry.key;
                                  final mapEntry = entry.value;
                                  return MoonTag(
                                    onTap: () {
                                      bloc.add(ClickLike(mapEntry.key));
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: state.filter.like == mapEntry.key
                                          ? context.moonColors!.piccolo
                                              .withOpacity(0.2)
                                          : context.moonColors!.beerus
                                              .withOpacity(0.5),
                                    ),
                                    label: Text(
                                      mapEntry.value,
                                      style: context.moonTypography!.body.text12
                                          .copyWith(
                                        color: state.filter.like == mapEntry.key
                                            ? context.moonColors!.piccolo
                                            : context.moonColors!.trunks,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              kPadding2.gap,
                              Text(
                                t.filter.date,
                                style: context.moonTypography!.heading.text16,
                              ),
                              kPadding.gap,
                              Wrap(
                                spacing: kPadding,
                                runSpacing: kPadding,
                                children: date.entries.map((entry) {
                                  final key = entry.key;
                                  final value = entry.value;
                                  return MoonTag(
                                    onTap: () {
                                      bloc.add(ClickDate(
                                          key)); // Send key instead of index
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: state.filter.date == key
                                          ? context.moonColors!.piccolo
                                              .withOpacity(0.3)
                                          : context.moonColors!.beerus
                                              .withOpacity(0.5),
                                    ),
                                    label: Text(
                                      value,
                                      style: context.moonTypography!.body.text12
                                          .copyWith(
                                        color: state.filter.date == key
                                            ? context.moonColors!.piccolo
                                            : context.moonColors!.trunks,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(kPadding),
                    child: Wrap(
                      spacing: kPadding,
                      runSpacing: kPadding,
                      children: [
                        ...List.generate(
                          state.tags.length,
                          (index) {
                            final tag = state.tags[index];
                            return CustomTagCard(
                              isOnSearch: true,
                              ontap: () {
                                bloc.add(SelectTag(index));
                              },
                              title: tag.name,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<FilterWidgetButtomsheetBloc,
              FilterWidgetButtomsheetState>(
            builder: (context, state) {
              return SafeArea(
                  child: Container(
                padding: EdgeInsets.all(kPadding),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: MoonButton(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     backgroundColor: context.moonColors!.beerus,
                    //     label: Text(t.common.cancel),
                    //   ),
                    // ),
                    // kPadding.gap,
                    Expanded(
                        child: CustomButtom(
                      title: state.filter.activeFilterCount > 0
                          ? "${t.filter.result} (${state.resultCount})"
                          : t.filter.result,
                      onTap: () {
                        Navigator.pop(context, state.filter);
                      },
                    )),
                  ],
                ),
              ));
            },
          ),
        );
      },
    );
  }
}

Map<String, String> status = {
  'no_answer': t.filter.noAnswer,
  'have_answer': t.filter.haveAnswer,
  'no_true_answer': t.filter.noTrueAnswer,
  'have_true_answer': t.filter.haveTrueAnswer,
};

Map<String, String> like = {
  'less': t.filter.lessLike,
  'more': t.filter.moreLike,
};

Map<String, String> date = {
  'newest': t.filter.newest,
  'oldest': t.filter.oldest,
};
Map<String, String> type = {
  'question': t.common.question,
  'discussion': t.common.discussion,
};
