import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class MessageDate extends StatelessWidget {
  final String date;
  const MessageDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Text(
        date,
        style: const TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
