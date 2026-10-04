import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../core/utils/widgets/custom_book.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../bloc/category_bloc.dart';

class MergeSaveScreen extends StatefulWidget {
  final int categoryIndex;
  final CategoryBloc categoryBloc;

  const MergeSaveScreen({
    super.key,
    required this.categoryIndex,
    required this.categoryBloc,
  });
  @override
  State<MergeSaveScreen> createState() => _MergeSaveScreenState();
}

class _MergeSaveScreenState extends State<MergeSaveScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.book.mergeBookTitle,
        isClose: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: kBorderWidthSmall,
          color: context.moonColors!.trunks,
        ))),
        width: double.infinity,
        child: Column(
          children: [
            kPadding2.gap,
            Expanded(
              child: Container(
                padding: kScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.book.mergeBookDes,
                      style: context.moonTypography!.body.text16
                          .copyWith(color: context.moonColors!.bulma),
                    ),
                    kPadding2.gap,
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: widget.categoryBloc.state.category
                            .asMap()
                            .entries
                            .map((e) {
                          return e.value.id !=
                                  widget.categoryBloc.state
                                      .category[widget.categoryIndex].id
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    widget.categoryBloc.add(
                                      MergeCategoryEvent(
                                          fromIndex: widget.categoryIndex,
                                          toIndex: e.key),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(bottom: kPadding),
                                    child: Row(
                                      children: [
                                        CustomBook(
                                          padding: const EdgeInsets.only(
                                              left: kPadding / 2,
                                              top: kPadding / 2),
                                          height: 60,
                                          width: 45,
                                          image: e.value.cover!,
                                        ),
                                        const Gap(kPadding2),
                                        Expanded(
                                            child: Text(
                                          e.value.name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }).toList(),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
