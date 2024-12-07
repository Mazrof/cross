import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class ChatTileWidget extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String time;
  final MessageStatus messageStatus; // Add message status parameter

  const ChatTileWidget({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.time,
    required this.messageStatus, // Initialize the new parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the icon and color based on messageStatus
    IconData? statusIcon;
    Color? iconColor;

    switch (messageStatus) {
      case MessageStatus.loading:
        statusIcon = Icons.access_time; // Clock icon for loading
        iconColor = Colors.grey;

        break;
      case MessageStatus.sent:
        statusIcon = Icons.check; // Single check for sent
        iconColor = Colors.grey;
        break;
      case MessageStatus.delivered:
        statusIcon = Icons.done_all; // Double check for delivered
        iconColor = Colors.grey;
        break;
      case MessageStatus.read:
        statusIcon = Icons.done_all; // Double check for read
        iconColor = Colors.blue; // Blue color for read messages
        break;
    }

    return ListTile(
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Time Text
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
          ),
          // Status Indicator Icon
        ],
      ),
      leading: Avatar(
        imageUrl: imageUrl,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Row(
        children: [
          if (statusIcon != null)
            Icon(
              statusIcon,
              color: iconColor,
              size: 20,
            ),
          SizedBox(width: 5),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
