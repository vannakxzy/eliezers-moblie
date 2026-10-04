import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:injectable/injectable.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../../../core/constants/constants.dart';
import '../../../di/di.dart';
import '../../../gen/i18n/translations.g.dart';
import '../page_route/app_route_info.dart';
import 'app_popup_info.dart';

abstract class BasePopupInfoMapper {
  Widget map(AppPopupInfo appPopupInfo, IAppNavigator navigator);
}

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appPopupInfo, IAppNavigator navigator) {
    return appPopupInfo.when(
      errorDialog: (
        message,
        onClose,
        onDismiss,
        title,
        titleClose,
        canDismiss,
      ) {
        final context = navigator.context;
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .8),
              width: double.infinity,
              padding: EdgeInsets.all(kPadding2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? 'Error',
                    style: context.moonTypography?.heading.text18,
                  ),
                  Gap(kPadding / 2),
                  Text(
                    message ?? '',
                    style: context.moonTypography?.body.text14,
                  ),
                  Gap(kPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MoonFilledButton(
                      buttonSize: MoonButtonSize.md,
                      onTap: () {
                        Navigator.pop(navigator.context);
                      },
                      label: Text(t.common.ok),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

      infoDialog: (
        message,
        onLeftAction,
        onRightAction,
        title,
        titleLeft,
        titleRight,
        canDismiss,
      ) =>
          const SizedBox(),

      confirmDialog: (message) {
        return const SizedBox.shrink();
        // return CommonDialog(
        //   actions: [
        //     PopupButton(
        //       text: S.current.ok,
        //       onPressed: onPressed ?? Func0(() => navigator.pop()),
        //     ),
        //   ],
        //   message: message,
        // );
      },
      errorWithRetryDialog: (message) {
        return const SizedBox.shrink();
        // return CommonDialog(
        //   actions: [
        //     PopupButton(
        //       text: S.current.cancel,
        //       onPressed: Func0(() => navigator.pop()),
        //     ),
        //     PopupButton(
        //       text: S.current.retry,
        //       onPressed: onRetryPressed ?? Func0(() => navigator.pop()),
        //       isDefault: true,
        //     ),
        //   ],
        //   message: message,
        // );
      },

      addNewQuestionModalBottomSheet: () => const Padding(
        padding: EdgeInsets.only(
          top: 0,
        ),
        // child: PostQuestionPage(band: BandEntity),
      ),
      unAuthenticated: (String message, void Function() onPressedButton) =>
          Padding(
        padding: const EdgeInsets.all(kPadding2),
        child: MoonModal(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kPadding2, vertical: kPadding2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('App take a little break!',
                    style: MoonTypography.typography.heading.text14),
                const Gap(kPadding),
                Text('We will be back very soon. Sorry for incovienence',
                    style: MoonTypography.typography.body.text12),
                const Gap(kPadding2),
                MoonFilledButton(
                  isFullWidth: true,
                  buttonSize: MoonButtonSize.md,
                  label: Text(t.common.ok),
                  onTap: () {
                    navigator.pop();
                    onPressedButton.call();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      customDialog: (Widget child) => child,
      modalLogin: () => const ModalLogin(),
      // ),
    );
  }
}

class ModalLogin extends StatelessWidget {
  const ModalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(kPadding2).copyWith(
          bottom: MediaQuery.viewInsetsOf(context).bottom + s3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.login.title,
              style: context.moonTypography?.heading.text14,
            ),
            const Gap(kPadding),
            MoonFormTextInput(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              hasFloatingLabel: true,
              textInputSize: MoonTextInputSize.lg,
              validator: (String? value) => value != null && value.length < 5
                  ? "The text should be longer than 5 characters."
                  : null,
              onChanged: (value) {},
              leading: const Icon(MoonIcons.mail_envelope_32_regular),
            ),
            const Gap(kPadding),
            MoonFormTextInput(
              hintText: 'Password',
              hasFloatingLabel: true,
              textInputSize: MoonTextInputSize.lg,
              keyboardType: TextInputType.visiblePassword,
              validator: (String? value) => value != null && value.length < 8
                  ? "The text should be longer than 5 characters."
                  : null,
              onChanged: (value) {},
              leading: const Icon(MoonIcons.security_key_32_regular),
              // obscureText: state.showPassword,
              // trailing: IconButton(
              //   visualDensity: VisualDensity.comfortable,
              //   onPressed: () {
              //   },
              //   icon: Icon(
              //     state.showPassword
              //         ? MoonIcons.controls_eye_32_regular
              //         : MoonIcons.controls_eye_crossed_32_regular,
              //   ),
              // ),
            ),
            const Gap(s3),
            MoonFilledButton(
              buttonSize: MoonButtonSize.md,
              isFullWidth: true,
              label: Text(t.login.title),
              onTap: () {
                getIt
                    .get<IAppNavigator>()
                    .replaceAll([const AppRouteInfo.login()]);
              },
            )
          ],
        ),
      ),
    );
  }
}
