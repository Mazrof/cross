import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/component/general_image.dart';

class ChatGroupTile extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final String lastSeen;

  const ChatGroupTile({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.lastSeen, required bool isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the icon and color based on messageStatus
    IconData? statusIcon;
    Color? iconColor;

    return ListTile(
      leading: GeneralImage(username: title, imageUrl: imageUrl),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Row(
        children: [
          SizedBox(width: 5),
          Text(
            lastSeen,
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
