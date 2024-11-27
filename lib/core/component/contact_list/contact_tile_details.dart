import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class ContactTileDetails extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  const ContactTileDetails(
      {super.key, required this.contactName, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactName,
        ),
        Text(
          lastMessage,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
