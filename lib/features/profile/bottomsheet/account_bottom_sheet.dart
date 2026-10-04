import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class AccountBottomSheet extends StatelessWidget {
  const AccountBottomSheet({super.key});

  static showBottomSheet(BuildContext context) => showModalBottomSheet(
        clipBehavior: Clip.antiAlias,
        context: context,
        builder: (_) => const AccountBottomSheet(),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: kPadding),
        child: Column(
          children: [
            AppBar(
              centerTitle: false,
              title: const Text('User Accounts'),
            ),
            ListTile(
              trailing: const Icon(
                Icons.link,
                color: Colors.blue,
              ),
              onTap: () {},
              title: const Text('Chhoeung Chhunvirak'),
              subtitle: const Text('chhun_virak'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('+ Add Account'),
            ),
          ],
        ),
      ),
    );
  }
}
