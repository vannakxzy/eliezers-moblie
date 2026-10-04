// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../presentation/bloc/bloc/select_audience_bloc.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../../shared/widgets/app_divider.dart';

import '../../../core/constants/constants.dart';
import '../presentation/widgets/select_audience.dart';

class SelectAudienceButtomsheet extends StatefulWidget {
  final String audience;
  const SelectAudienceButtomsheet({
    super.key,
    required this.audience,
  });

  static Future<String> show(BuildContext context, String audience) async =>
      await showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (_) => SelectAudienceButtomsheet(
          audience: audience,
        ),
        backgroundColor: Colors.transparent,
      );

  @override
  State<SelectAudienceButtomsheet> createState() =>
      _SelectAudienceButtomsheetState();
}

class _SelectAudienceButtomsheetState
    extends BasePageBlocState<SelectAudienceButtomsheet, SelectAudienceBloc> {
  @override
  void initState() {
    bloc.add(InitPage(widget.audience));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.audience.title,
        isClose: true,
      ),
      body: BlocBuilder<SelectAudienceBloc, SelectAudienceState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding2),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevent column overflow
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.audience.description01,
                    style: context.moonTypography!.heading.text18,
                  ),
                  Text(
                    t.audience.description02,
                    style: context.moonTypography!.body.text16,
                  ),
                  kPadding2.gap,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.audience.chooseAudience,
                          style: context.moonTypography!.heading.text18,
                        ),
                        kPadding2.gap,
                        SelectAudienceWidget(
                          ontap: () {
                            bloc.add(ClickAudienceEvent("public"));
                          },
                          title: t.post.public,
                          decoration: t.audience.publicDes,
                          isSelect: state.audience == "public" ? true : false,
                          leading: MoonIcons.generic_globe_16_light,
                        ),
                        SelectAudienceWidget(
                          ontap: () {
                            bloc.add(ClickAudienceEvent("onlyme"));
                          },
                          title: t.post.onlyme,
                          decoration: t.post.onlyme,
                          isSelect: state.audience == "onlyme" ? true : false,
                          leading: MoonIcons.security_lock_16_light,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20), // Ensures visibility
                    child: Column(
                      children: [
                        AppDivider.large(
                          color: context.moonColors!.beerus,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: state.audience == state.oldAudience
                                  ? context.moonColors!.trunks
                                  : context.moonColors!
                                      .piccolo, // Color when checked
                              side: BorderSide(
                                  color: context.moonColors!.trunks, width: 2),
                              value: state.isSetDefault ? true : false,
                              onChanged: (value) {
                                bloc.add(ClickSetDefualt());
                              },
                            ),
                            Text(
                              t.audience.setAsDefault,
                              style: context.moonTypography!.body.text14
                                  .copyWith(color: context.moonColors!.trunks),
                            )
                          ],
                        ),
                        CustomButtom(
                          title: t.common.done,
                          isFullWidth: true,
                          onTap: () {
                            bloc.add(ClickDone());
                            Navigator.pop(context, state.audience);
                          },
                        ),
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
