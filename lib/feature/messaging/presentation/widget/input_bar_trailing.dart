import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class InputBarTrailing extends StatelessWidget {
  const InputBarTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.attach_file),
          color: AppColors.grey,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.send),
          color: AppColors.grey,
          onPressed: () {
            // Todo
          },
        ),
      ],
    );
  }
}
