import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: ListView(children: [
        CustomTile(
          title: "New Group",
          icon: Icons.group,
          onPressed: () {},
        ),
        CustomTile(
          title: "New Contact",
          icon: Icons.add,
          onPressed: () {
            _showModalBottomSheet(context);
          },
        ),
        CustomTile(
          title: "New Channel",
          icon: Icons.group_work,
          onPressed: () {},
        ),
        const ContactList()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('New Contact',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'First name (required)',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Last name (optional)',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.flag),
                  prefixText: '+20 ',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Create Contact'),
              ),
            ],
          ),
        );
      },
    );
  }
}
