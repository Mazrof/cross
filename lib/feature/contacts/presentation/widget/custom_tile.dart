import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final onPressed;
  const CustomTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.grey,
      ),
      title: TextButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
