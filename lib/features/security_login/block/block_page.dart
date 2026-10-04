import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_empty_data.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_avata.dart';
import '../../../shared/widgets/app_refresh_indicator.dart';
import 'bloc/block_bloc.dart';

@RoutePage()
class BlockPage extends StatefulWidget {
  const BlockPage({super.key});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends BasePageBlocState<BlockPage, BlockBloc> {
  @override
  @override
  void initState() {
    bloc.add(GetBlockEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.block,
      ),
      body: SafeArea(
        child: BlocBuilder<BlockBloc, BlockState>(
          builder: (context, state) {
            return state.isLoading && state.blocks.isEmpty
                ? const Center(
                    child: CustomLoading(),
                  )
                : state.blocks.isEmpty
                    ? const CustomEmptyData()
                    : AppSmartRefreshScrollView(
                        enableLoadMore: state.isMorePage,
                        onLoadMore: () async => bloc.add(GetBlockEvent()),
                        onRefresh: () async => bloc.add(RefreshPage()),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final user = state.blocks[index];
                              return MoonMenuItem(
                                onTap: () {},
                                leading: CustomAvatar(
                                  image: user.profile,
                                ),
                                label: Text(user.name,
                                    style: context.moonTypography!.body.text14
                                        .copyWith(fontWeight: FontWeight.w500)),
                                content: Text(user.date),
                                trailing: TextButton(
                                    onPressed: () {
                                      bloc.add(ClickUnBlockEvent(index));
                                    },
                                    child: Text(t.common.unBlock,
                                        style: context
                                            .moonTypography!.body.text12
                                            .copyWith(
                                                color:
                                                    context.moonColors!.piccolo,
                                                fontWeight: FontWeight.w500))),
                              );
                            },
                            separatorBuilder: (context, index) => const Gap(0),
                            itemCount: state.blocks.length),
                      );
          },
        ),
      ),
    );
  }
}
