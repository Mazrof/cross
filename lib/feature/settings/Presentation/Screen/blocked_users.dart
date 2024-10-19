import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person_add_alt),
            title: Text(
              "Block user",
              style: TextStyle(color: Colors.lightBlue),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'If enabled, all new messages in chats you start will be automatically deleted for everyone at some point after they are sent.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
