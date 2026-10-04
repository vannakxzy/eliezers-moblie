import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';
import 'package:moon_design/moon_design.dart';
import '../../../../core/utils/widgets/custom_loading.dart';

import '../../../../di/di.dart';
import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../create_account/select_avatar/bloc/bloc.dart';

class SelectAvatarBottomSheet extends StatefulWidget {
  const SelectAvatarBottomSheet._({this.selectedAvatar});
  final String? selectedAvatar;

  static Future<String?> show(BuildContext context, [String? selectedAvatar]) =>
      showMoonModalBottomSheet(
        context: context,
        builder: (_) => SelectAvatarBottomSheet._(
          selectedAvatar: selectedAvatar,
        ),
      );

  @override
  State<SelectAvatarBottomSheet> createState() =>
      _SelectAvatarBottomSheetState();
}

class _SelectAvatarBottomSheetState extends State<SelectAvatarBottomSheet> {
  late String? selected = widget.selectedAvatar;
  final avatarBloc = getIt.get<SelectAvatarBloc>()..add(GetAvatar());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAvatarBloc, SelectAvatarState>(
      bloc: avatarBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPadding2, vertical: kPadding2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const CloseButton(),
                  const Gap(kPadding2),
                  Text(
                    t.selectAvatar.title,
                    style: context.moonTypography?.heading.text16,
                  ),
                ],
              ),
              const Gap(kPadding2),
              if (state.isLoadin) const Center(child: CustomLoading()),
              GridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                mainAxisSpacing: kPadding2,
                crossAxisSpacing: kPadding,
                crossAxisCount: 5,
                children: [
                  ...state.avatar.map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = e.name;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(selected != e.name ? 4 : 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selected == e.name
                                ? context.moonColors!.piccolo
                                : Colors.transparent,
                            width: selected == e.name ? 1 : 0,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: e.name,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(s3),
              SafeArea(
                top: false,
                child: CustomButtom(
                  title: t.common.update,
                  isFullWidth: true,
                  onTap: widget.selectedAvatar != selected
                      ? () {
                          Navigator.of(context).pop(selected);
                        }
                      : null,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
