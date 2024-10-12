import 'package:flutter/material.dart';
import 'package:telegram/core/component/contact_list/contact_list_tile.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => const ContactListTile(
        imageUrl:
            "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
        contactName: "Kiro",
        lastMessage: "Hallo, zusammen!!",
      ),
    );
  }
}
