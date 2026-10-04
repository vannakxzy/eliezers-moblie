import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import '../bloc/feedback_bloc.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

@RoutePage()
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends BasePageBlocState<FeedbackPage, FeedbackBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "មតិ"),
      body: Container(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "សូមធ្វើការផ្តល់មតិកែលម្អដោយរអាម្មរណ៏ធម្មតាតែយ៉ាងហោចណាស់សូមមាន ១០​ពាក្យ ",
              style: context.moonTypography?.body.text16,
            ),
            const Gap(kPadding),
            BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (_, state) {
                return MoonTextArea(
                  onTapOutside: (event) {
                    unFocus();
                  },
                  enabled: !state.isLoading,
                  height: context.height * .2,
                  onChanged: (value) {
                    bloc.add(DescriptionChangedEvent(value));
                  },
                  controller: bloc.descriptionTextController,
                );
              },
            ),
            const Gap(kPadding2),
            BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (_, state) {
                return CustomButtom(
                  isFullWidth: true,
                  isloading: state.isLoading,
                  title: t.common.submit,
                  disable: state.description.length < 15,
                  onTap: state.description.length > 15
                      ? () {
                          bloc.add(ClickSubmitEvent());
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
