import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class UserInfo extends StatelessWidget {
  final String userNumber;
  const UserInfo({super.key, required this.userNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSizes.xxs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Info', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 5),
                Text(
                  userNumber,
                  style: const TextStyle(color: AppColors.grey, fontSize: 16),
                ),
                Text(
                  'Mobile',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
