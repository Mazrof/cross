import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class ContactTile extends StatelessWidget {
  final String imageUrl;
  final String contactName;
  final Widget? trailing;
  final GestureTapCallback? onTap;

  const ContactTile(
      {super.key,
      required this.imageUrl,
      required this.contactName,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.sm, right: AppSizes.sm),
      child: ListTile(
        leading: Avatar(imageUrl: imageUrl),
        title: Text(contactName),
        trailing: trailing,
        contentPadding: const EdgeInsets.all(8),
        onTap: onTap,
      ),
    );
  }
}
