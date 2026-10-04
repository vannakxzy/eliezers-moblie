import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/custom_loading.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

import '../bloc/update_avatar_bloc.dart';

@RoutePage()
class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({super.key});

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState
    extends BasePageBlocState<UpdateAvatarPage, UpdateAvatarBloc> {
  @override
  void initState() {
    bloc.add(GetAvatarEvent());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: t.selectAvatar.title,
        ),
        body: SafeArea(
          child: BlocBuilder<UpdateAvatarBloc, UpdateAvatarState>(
            builder: (context, state) {
              return Container(
                padding: kScreenPadding,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: kPadding2),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          image: state.selectedIndex >= 0
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      state.avatar[state.selectedIndex].name),
                                  fit: BoxFit.cover)
                              : null),
                    ),
                    Expanded(
                      child: state.isLoadin
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : Column(
                              children: [
                                Wrap(
                                  children: [
                                    ...List.generate(
                                      state.avatar.length,
                                      (index) {
                                        final avatar = state.avatar[index];
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.add(ClickAvatarEvent(index));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.all(kPadding),
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                color:
                                                    context.moonColors!.piccolo,
                                                image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            avatar.name),
                                                    fit: BoxFit.cover)),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              bloc.add(ClickCancelEvent());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Center(child: Text(t.common.cancel)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              bloc.add(ClickConfirmEvent());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color:
                                      const Color.fromARGB(255, 213, 121, 131)),
                              child: Center(child: Text(t.common.confirm)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
