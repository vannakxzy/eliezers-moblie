import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/constants/size_constant.dart';
import '../../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../../config/router/page_route/app_route_info.dart';
import '../../../../../core/utils/widgets/custom_buttom.dart';
import '../bloc/welcome_bloc.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends BasePageBlocState<WelcomePage, WelcomeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: CustomPaint(
              child: Container(
                padding: const EdgeInsets.only(left: kPadding, top: kPadding),
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: MediaQuery.sizeOf(context).width * 0.9,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPadding2, top: kPadding),
                        child: Text(
                          "សួស្ដីមកកាន់នាង​សីតា",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(children: [
              const Spacer(),
              CustomButtom(
                title: "ចូលប្រើ",
                onTap: () {
                  appRoute.push(const AppRouteInfo.login());
                },
              ),
              const Gap(kPadding),
              CustomButtom(
                outline: true,
                title: "បង្កើតគណនី",
                onTap: () {
                  // context.goNamed('create-account');
                },
              ),
              const Gap(30),
            ]),
          ),
        ],
      ),
    );
  }
}
