import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class MessageDate extends StatelessWidget {
  final String date;
  const MessageDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: AppSizes.xs,
            bottom: AppSizes.xs,
            left: AppSizes.xxs,
            right: AppSizes.xxs,
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(AppSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.xl),
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
