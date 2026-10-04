import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/widgets/custom_buttom.dart';
import '../../../core/utils/widgets/custom_loading.dart';
import '../presentation/bloc/bloc.dart';

import '../../../gen/i18n/translations.g.dart';
import 'bloc/select_subject_bloc.dart';

@RoutePage()
class SeletctSubjectPage extends StatefulWidget {
  const SeletctSubjectPage({super.key});

  @override
  State<SeletctSubjectPage> createState() => _SeletctSubjectPageState();
}

class _SeletctSubjectPageState
    extends BasePageBlocState<SeletctSubjectPage, SelectSubjectBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(GetSubjectEvent());
  }

  late CreateAccountBloc myBloc;

  @override
  Widget buildPage(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocBuilder<SelectSubjectBloc, SelectSubjectState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(kPadding2),
              child: Column(
                children: [
                  Text(
                    t.subject.selectSubjectTitle,
                    style: context.moonTypography!.heading.text24,
                  ),
                  kPadding2.gap,
                  Text(
                    t.subject.selectSubjectDes,
                    style: context.moonTypography!.body.text16,
                  ),
                  kPadding2.gap,
                  Expanded(
                    child: state.isloading
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : Wrap(
                            spacing: kPadding,
                            runSpacing: kPadding,
                            alignment: WrapAlignment.center,
                            children: [
                              if (state.subject.isNotEmpty)
                                ...List.generate(state.subject.length, (index) {
                                  final subject = state.subject[index];
                                  return MoonTag(
                                    onTap: () {
                                      bloc.add(
                                          ClickSelectSubjectEvent(subject.id!));
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kPadding),
                                      color: state.selectedSucject
                                              .contains(subject.id!)
                                          ? context.moonColors!.piccolo
                                              .withOpacity(0.7)
                                          : context.moonColors!.beerus,
                                    ),
                                    tagSize: MoonTagSize.sm,
                                    label: Text(
                                      "${subject.title}",
                                      style: context
                                          .moonTypography!.heading.text16
                                          .copyWith(
                                              color: state.selectedSucject
                                                      .contains(subject.id!)
                                                  ? Colors.white
                                                  : context.moonColors!.bulma,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  );
                                })
                            ],
                          ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MoonTextButton(
                          onTap: () {
                            bloc.add(ClickSkipEvent());
                          },
                          label: Text(t.common.skip),
                        ),
                      ),
                      Expanded(
                        child: CustomButtom(
                          disable: !state.selectedSucject.isNotEmpty,
                          title: t.common.next,
                          onTap: () {
                            bloc.add(ClickConfirmEvent());
                          },
                          isloading: state.loadingUpdateSubject,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
