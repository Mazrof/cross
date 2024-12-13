import 'package:flutter/material.dart';
import 'package:telegram/core/component/general_image.dart';

class GroupTile extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String time;

  const GroupTile({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.time,
    required String lastSeen, // Initialize the new parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      leading: GeneralImage(username: title, imageUrl: imageUrl),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Row(
        children: [
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
