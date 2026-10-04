import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../core/constants/size_constant.dart';
import 'package:share_plus/share_plus.dart';

class MyQrDialog extends StatelessWidget {
  const MyQrDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const MyQrDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(s3),
            //   ),
            //   width: context.width * .7,
            //   height: context.width * .7,
            //   child: Stack(
            //     children: [
            //       CachedNetworkImage(
            //         imageUrl:
            //             'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/2048px-QR_code_for_mobile_English_Wikipedia.svg.png',
            //       ),
            //       const Center(
            //         child: ProfileTabAvatar(
            //           borderColor: Colors.white,
            //           size: 50,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Space.p2,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  label: const Text('Save'),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.save_rounded,
                    size: 18,
                  ),
                ),
                Space.kSpace,
                ElevatedButton.icon(
                  label: const Text('Share'),
                  onPressed: () {
                    Share.share('Follow me on IShare App by KonKhmer');
                  },
                  icon: const Icon(
                    Icons.share_rounded,
                    size: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
