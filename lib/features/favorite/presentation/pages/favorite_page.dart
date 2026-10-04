import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends BasePageBlocState<FavoritePage, FavoriteBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold();
  }
}
