import 'package:flutter/material.dart';
import '../../../../../core/utils/widgets/custom_textfield.dart';

class SearchTextfield extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String?>? onSubmitted;
  const SearchTextfield({
    super.key,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      height: 45,
      prefixIcon: const Icon(
        Icons.search_rounded,
        // size: 18,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintText: 'គណិត, របៀបរៀន, គន្លឹះ, សមីការ, . . .',
      // suffixIcon: TextButton(
      //     onPressed: () {},
      //     child: const Text(
      //       'Cancel',
      //     )
      //     //  const Icon(
      //     //   MoonIcons.controls_close_24_regular,
      //     //   size: 16,
      //     // ),
      //     ),
    );
  }
}
