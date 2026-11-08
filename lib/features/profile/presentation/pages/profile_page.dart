import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final int userId;
  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageBlocState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    bloc.add(InitPageEvent(widget.userId));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
