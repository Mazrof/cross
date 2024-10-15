import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/component/contact_list/contact_list_trailing.dart';
import 'package:telegram/core/component/contact_list/contact_tile_details.dart';

class ContactListTile extends StatelessWidget {
  final String imageUrl;
  final String contactName;
  final String lastMessage;

  const ContactListTile({
    super.key,
    required this.imageUrl,
    required this.contactName,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(
        imageUrl: imageUrl,
      ),
      title: ContactTileDetails(
        contactName: contactName,
        lastMessage: lastMessage,
      ),
      trailing: const ContactListTrailing(
          sendingTime: "12:00", unreadCount: 12, seen: true),
      contentPadding: const EdgeInsets.all(4),
    );
  }
}
