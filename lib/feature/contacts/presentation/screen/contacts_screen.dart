import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/contact_list/contact_list.dart';
import 'package:telegram/core/component/popup_menu.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/contacts/presentation/widget/custom_tile.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          onLeadingTap: () {},
          showBackButton: true,
          title: const Text(
            "Contacts",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // to be implemented
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  // to be implemented
                },
                icon: const Icon(Icons.sort)),
          ]),
      body: ListView(children: const [
        CustomTile(
          title: "New Group",
          icon: Icons.group,
        ),
        CustomTile(
          title: "New Contact",
          icon: Icons.add,
        ),
        CustomTile(
          title: "New Channel",
          icon: Icons.group_work,
        ),
        ContactList()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
