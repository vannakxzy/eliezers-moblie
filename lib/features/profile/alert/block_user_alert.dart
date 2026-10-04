import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_design/moon_design.dart';
import '../../../di/di.dart';
import '../../../core/constants/constants.dart';
import '../../notification/domain/entities/user_entity.dart';
import '../../question_detail/presentation/bloc/bloc.dart';
import '../../../gen/i18n/translations.g.dart';

class BlockUserAlert extends StatefulWidget {
  final UserEntity user;

  const BlockUserAlert({
    super.key,
    required this.user,
  });

  static Future<bool> show({
    required BuildContext context,
    required UserEntity user,
  }) async =>
      await showDialog(
        context: context,
        builder: (_) => BlockUserAlert(user: user),
      );

  @override
  State<BlockUserAlert> createState() => _BlockUserAlertState();
}

class _BlockUserAlertState extends State<BlockUserAlert> {
  late QuestionDetailBloc mybloc;
  @override
  void initState() {
    super.initState();
    mybloc = getIt.get<QuestionDetailBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionDetailBloc, QuestionDetailState>(
      bloc: mybloc,
      builder: (context, state) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: kPadding2 * 2),
          contentPadding: const EdgeInsets.all(kPadding2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${t.common.block}  ${widget.user.name} ?",
                  style: context.moonTypography!.heading.text14,
                ),
                kPadding.gap,
                Text(t.block.des,
                    textAlign: TextAlign.center,
                    style: context.moonTypography!.body.text14
                        .copyWith(color: context.moonColors!.trunks)),
                kPadding.gap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MoonButton(
                        backgroundColor: context.moonColors!.trunks,
                        buttonSize: MoonButtonSize.sm,
                        label: Text(
                          t.common.cancel,
                          style: context.moonTypography!.heading.text14
                              .copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    kPadding.gap,
                    MoonButton(
                        backgroundColor: context.moonColors!.jiren,
                        buttonSize: MoonButtonSize.sm,
                        label: Text(
                          t.common.yes,
                          style: context.moonTypography!.heading.text14
                              .copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context, true);
                          mybloc.add(ClickBlockUserEvent(widget.user.id));
                        }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
