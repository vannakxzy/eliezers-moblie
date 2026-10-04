import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../extension/string_extension.dart';
import 'package:moon_design/moon_design.dart';

import '../../../config/router/app_router.dart';
import '../../../di/di.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    this.body,
    this.title,
    this.desctioption,
    this.automaticallyImplyLeading = true,
  });
  final String? title;
  final String? desctioption;
  final Widget? body;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // spacing: kPadding,
          children: [
            if (parentRoute?.impliesAppBarDismissal == true &&
                automaticallyImplyLeading)
              MoonButton.icon(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: MoonSizes.sizes.sm,
                ),
                onTap: () {
                  getIt.get<AppRouter>().maybePop();
                },
              ),
            if (title.isNotEmptyOrNull)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                child: Text(
                  title!,
                  style: context.moonTypography?.heading.text24,
                ),
              ),
            if (desctioption.isNotEmptyOrNull)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding2),
                child: Text(
                  desctioption!,
                  style: context.moonTypography?.heading.text32,
                ),
              ),
            if (body != null)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(kPadding2, 4, kPadding2, 0),
                  child: ClipRRect(
                    borderRadius:
                        context.moonBorders?.interactiveSm ?? BorderRadius.zero,
                    child: body!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
