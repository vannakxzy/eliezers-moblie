import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';

class ProfileDataEmpty extends StatelessWidget {
  final int userId;
  const ProfileDataEmpty({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 0.5),
        bottom: BorderSide(width: 0.5),
      )),
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      alignment: Alignment.center,
      child: userId == 0
          ? Column(
              children: [
                Text(t.profileInfo.yourEmpty),
                // kPadding2.gap,
                // CustomButtom(
                //   title: t.profileInfo.buttonEmpty,
                //   onTap: () {},
                // )
              ],
            )
          : Column(
              children: [
                Text(t.profileInfo.anonymousEmpty),
                kPadding2.gap,
              ],
            ),
    );
  }
}
