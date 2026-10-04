import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/constants/constants.dart';
import '../widgets/data_tag_answer_page.dart';
import '../widgets/data_tag_question_page.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../profile/domain/entities/top_tag_entity.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class DataTagPage extends StatefulWidget {
  final List<TopTagEntity> tag;
  final int userId;
  final int index;
  const DataTagPage({
    super.key,
    required this.tag,
    required this.userId,
    required this.index,
  });
  @override
  State<DataTagPage> createState() => _DataTagPageState();
}

class _DataTagPageState extends BasePageBlocState<DataTagPage, DataTagBloc>
    with SingleTickerProviderStateMixin {
  TabController? _tabControllerMain;
  @override
  void initState() {
    _tabControllerMain = TabController(
        length: widget.tag.length,
        vsync: this,
        initialIndex: widget.index,
        animationDuration: Duration.zero);
    super.initState();
  }

  @override
  void dispose() {
    _tabControllerMain?.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return DefaultTabController(
      length: widget.tag.length,
      child: BlocBuilder<DataTagBloc, DataTagState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: TabBar(
                      controller: _tabControllerMain,
                      splashFactory: NoSplash.splashFactory,
                      tabAlignment: TabAlignment.center,
                      unselectedLabelColor:
                          context.moonColors!.trunks.withOpacity(0.6),
                      labelColor: context.moonColors!.bulma,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 3, color: context.moonColors!.bulma),
                      ),
                      indicatorColor: Colors.transparent,
                      labelPadding:
                          const EdgeInsets.symmetric(horizontal: kPadding),
                      tabs: [
                        ...List.generate(
                          widget.tag.length,
                          (index) {
                            final tag = widget.tag[index];
                            return Tab(
                              text: tag.name,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabControllerMain,
                      children: [
                        ...List.generate(
                            widget.tag.length,
                            (index) => DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: TabBar(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            dividerHeight: 0.5,
                                            unselectedLabelColor: context
                                                .moonColors!.trunks
                                                .withOpacity(0.6),
                                            labelColor:
                                                context.moonColors!.bulma,
                                            indicatorPadding: EdgeInsets.zero,
                                            indicatorColor: Colors.transparent,
                                            padding: EdgeInsets.zero,
                                            tabAlignment: TabAlignment.center,
                                            labelStyle: context
                                                .moonTypography!.body.text12,
                                            isScrollable: true,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            tabs: [
                                              Tab(
                                                text: t.common.question,
                                              ),
                                              Tab(text: t.common.answer),
                                            ]),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            DataTagQuestion(
                                                tag: widget.tag,
                                                index: index,
                                                tagId: widget.tag[index].id,
                                                userId: widget.userId),
                                            DataTagAnswer(
                                                topTagEntity: widget.tag,
                                                index: index,
                                                tagId: widget.tag[index].id,
                                                userId: widget.userId)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
