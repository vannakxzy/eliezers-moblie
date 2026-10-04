import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/widgets/custom_buttom.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: CustomPaint(
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 10),
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: MediaQuery.sizeOf(context).width * 0.9,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "សួស្ដីមកកាន់នាង​សីតា",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(children: [
              const Spacer(),
              CustomButtom(
                title: "ចូលប្រើ",
                onTap: () {
                  // context.goNamed("login-screen");
                },
              ),
              const Gap(8),
              CustomButtom(
                outline: true,
                title: "បង្កើតគណនី",
                onTap: () {
                  // context.goNamed('create-account');
                },
              ),
              const Gap(30),
            ]),
          ),
        ],
      ),
    );
  }
}
