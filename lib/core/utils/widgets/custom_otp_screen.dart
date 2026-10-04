import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../extension/string_extension.dart';
import '../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';
import 'package:pinput/pinput.dart';

class CustomOtpScreen extends StatefulWidget {
  final ValueChanged<String> validator;
  final ValueChanged<String> onChanged;
  final Function ontapReSend;
  final String? mainTitle;
  final String title;
  final bool errorState;
  final bool isloading;
  const CustomOtpScreen({
    super.key,
    required this.validator,
    required this.title,
    required this.ontapReSend,
    this.errorState = false,
    this.isloading = false,
    required this.onChanged,
    this.mainTitle,
  });

  @override
  State<CustomOtpScreen> createState() => _CustomOtpScreenState();
}

class _CustomOtpScreenState extends State<CustomOtpScreen> {
  Timer? time;
  final controller = OtpController();
  TextEditingController otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (controller.time.value > 0) {
        controller.time.value = controller.time.value - 1;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    time!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleMedium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius2),
        border: Border.all(color: const Color.fromARGB(255, 82, 81, 81)),
      ),
    );
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.mainTitle.isNotEmptyOrNull)
                Text(
                  widget.mainTitle!,
                  style: context.moonTypography?.heading.text32,
                ),
              Gap(4),
              Text(
                widget.title,
                style: context.moonTypography?.body.text18,
                textAlign: TextAlign.left,
              ),
              Column(
                children: [
                  const Gap(kPadding2),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: otpController,
                      // autofocus: true,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (value) {
                        return null;

                        // FocusScope.of(context).unfocus();
                        // await  Future.delayed(Duration(milliseconds: 100));
                        // widget.validator(value.toString());
                        // return null;
                      },
                      onCompleted: (pin) async {
                        FocusScope.of(context)
                            .unfocus(); // Hide keyboard after input is complete
                        await Future.delayed(Duration(milliseconds: 100));
                        widget.validator(pin.toString());
                      },
                      onChanged: (value) {
                        widget.onChanged(value);
                      },
                      errorText: t.common.worngOtp,
                      forceErrorState: widget.errorState,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      isCursorAnimationEnabled: false,
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: AppColor.successColor,
                          ),
                        ],
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(
                            color: const Color.fromARGB(255, 225, 85, 85)),
                      ),
                    ),
                  ),
                  kPadding2.gap,
                  if (widget.isloading)
                    MoonCircularLoader(
                      sizeValue: 20,
                      color: context.moonColors!.piccolo,
                    )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.common.notGetOtp,
                    style: context.moonTypography!.body.text14
                        .copyWith(color: context.moonColors!.trunks),
                  ),
                  kPadding.gap,
                  GestureDetector(
                    onTap: () {
                      if (controller.time.value == 0) {
                        widget.ontapReSend();
                        controller.time.value = 60;
                        setState(() {
                          otpController.text = '';
                        });
                      }
                    },
                    child: Text(
                      controller.time.value == 0
                          ? t.common.sendAgain
                          : "${controller.time.value} ${t.common.second}",
                      style: context.moonTypography!.body.text14.copyWith(
                          color: context.moonColors!.piccolo,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              kPadding.gap,
            ],
          ),
        ),
      ),
    );
  }
}

class OtpController extends GetxController {
  final time = 60.obs;
}
