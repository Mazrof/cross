import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class CAppDivider extends StatelessWidget {
  const CAppDivider({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          thickness: 2,
          color: AppColors.dividerColor,
        )),
        Text(
          '  $title  ',
          style: const TextStyle(color: AppColors.dividerColor),
        ),
        const Expanded(
            child: Divider(
          thickness: 2,
          color: AppColors.dividerColor,
        )),
      ],
    );
  }
}
