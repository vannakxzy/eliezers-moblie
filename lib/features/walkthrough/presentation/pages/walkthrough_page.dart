import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../app/base/navigation/app_navigator.dart';
import '../../../../di/di.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../shared/widgets/app_text.dart';

import '../../../../config/router/page_route/app_route_info.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState
    extends BasePageBlocState<WalkthroughPage, WalkthroughBloc> {
  final subjects = [
    "American literature",
    "British literature",
    "Contemporary literature",
    "Creative writing",
    "Communication skills",
    "Debate",
    "English language and composition",
    "English literature and composition",
    "Humanities",
    "Journalism",
    "Literary analysis",
    "Modern literature",
    "Poetry",
    "Popular literature",
    "Rhetoric",
    "Technical writing",
    "Works of Shakespeare",
    "World literature",
    "Written and oral communication",
  ];
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 150,
                  centerTitle: false,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: kPadding2, bottom: kPadding2),
                    centerTitle: false,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Choose Your Favourite',
                          style: context.textTheme.headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        AppText(
                          'All your favourite will be shown on your newsfeed.',
                          style: context.moonTypography?.body.text14
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Skip'),
                    )
                  ],
                ),
              ],
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                children: [
                  GridView.count(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: .7,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: kPadding2,
                    crossAxisSpacing: kPadding2,
                    children: [
                      ...subjects.map(
                        (subject) => FavouriteWidget(title: subject),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.all(kPadding2),
            child: MoonFilledButton(
              isFullWidth: true,
              label: const Text('Next'),
              onTap: () {
                getIt.get<IAppNavigator>().push(const AppRouteInfo.login());
              },
            ),
          )
        ],
      ),
    );
  }
}

class FavouriteWidget extends StatelessWidget {
  final String title;
  const FavouriteWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: ShapeDecorationWithPremultipliedAlpha(
              color: context.theme.colorScheme.secondary,
              shape: const MoonSquircleBorder(
                borderRadius: MoonSquircleBorderRadius.all(
                  MoonSquircleRadius(
                    cornerRadius: 20,
                  ),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              MoonIcons.other_crown_32_regular, color: Colors.white,
              size: 70,
              // color: Colors.black,
            ),
          ),
        ),
        const Gap(kPadding / 2),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: AppText(
              title,
              style: context.moonTypography?.body.text14,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
