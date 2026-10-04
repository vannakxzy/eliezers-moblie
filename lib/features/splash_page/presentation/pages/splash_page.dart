import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../bottom_navigationbar/bloc/scaffold_with_navbar_bloc.dart';
import '../bloc/splash_page_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageBlocState<SplashPage, SplashPageBloc> {
  @override
  void initState() {
    super.initState();
    // context.read<ScaffoldWithNavbarBloc>().add();

    bloc.add(InitSplashPageEvent());
  }

  @override
  Widget buildPage(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: BlocBuilder<SplashPageBloc, SplashPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: LottieBuilder.asset(
                      'assets/animations/splash_question.json',
                      width: MediaQuery.sizeOf(context).width * .7,
                      repeat: false,
                    ),
                  ),
                ),
                BlocBuilder<SplashPageBloc, SplashPageState>(
                  builder: (_, state) {
                    if (state.slogan != '') {
                      return Text(
                        state.slogan,
                        textAlign: TextAlign.center,
                        style: context.moonTypography?.body.text14.copyWith(
                          color: const Color(0xFF01579B),
                        ),
                      ).animate().fade().shimmer(duration: 3.seconds);
                    }
                    return SizedBox.shrink();
                  },
                ),
                Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
