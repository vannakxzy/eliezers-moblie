import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';

@RoutePage()
class TesthomePage extends StatefulWidget {
  const TesthomePage({super.key});
  @override
  State<TesthomePage> createState() => _TesthomePageState();
}

class _TesthomePageState extends BasePageBlocState<TesthomePage, TesthomeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TesthomeBloc, TesthomeState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      bloc.add(SumX());
                    },
                    child: Text("Add")),
                Text("${state.x}")
              ],
            ),
          );
        },
      ),
    );
  }
}
