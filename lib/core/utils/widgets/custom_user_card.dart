import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../features/profile/domain/entities/profile_entity.dart';
import '../../constants/constants.dart';
import 'custom_avata.dart';

class CustomAddUserCard extends StatelessWidget {
  final Function ontap;
  final bool isSelect;
  final Function select;
  final ProfileEntity user;
  const CustomAddUserCard(
      {super.key,
      required this.ontap,
      required this.select,
      required this.user,
      this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      menuItemPadding: EdgeInsets.zero,
      onTap: () {
        ontap();
      },
      leading: Row(
        children: [
          InkWell(
            onTap: () {
              if (user.bandRole == "") {
                select();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isSelect || user.bandRole != ""
                  ? Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.moonColors!.piccolo),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.moonColors!.piccolo),
                      ),
                    )
                  : Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.moonColors!.bulma),
                      ),
                    ),
            ),
          ),
          kPadding.gap,
          CustomAvatar(image: user.profile, name: user.name),
        ],
      ),
      label: Padding(
        padding: EdgeInsets.only(left: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
            ),
            Text(
              "${user.totalQuestions} . ${user.totalAnswers} . ${user.totalFavourites} . ${user.correctAnswers}  ",
              style: context.moonTypography!.body.text14
                  .copyWith(color: context.moonColors!.trunks),
            ),
          ],
        ),
      ),
      trailing: user.bandRole != ""
          ? Text(user.bandRole,
              style: context.moonTypography!.body.text16.copyWith(
                  color: user.bandRole == "owner"
                      ? context.moonColors!.piccolo
                      : context.moonColors!.trunks))
          : null,
    );
  }
}
