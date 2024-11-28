import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/component/contact_list/contact_tile_details.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class ContactListTile extends StatelessWidget {
  final String imageUrl;
  final String contactName;
  final String subTitle;
  final Widget? trailing;

  const ContactListTile({
    super.key,
    required this.imageUrl,
    required this.contactName,
    required this.subTitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.sm, right: AppSizes.sm),
      child: ListTile(
        leading: Avatar(
          imageUrl: imageUrl,
        ),
        title: ContactTileDetails(
          contactName: contactName,
          lastMessage: subTitle,
        ),
        trailing: trailing,
        // trailing: const ContactListTrailing(
        //   sendingTime: "12:00",
        //   unreadCount: 12,
        //   seen: true,
        // ),
        contentPadding: const EdgeInsets.all(4),
      ),
    );
  }
}
