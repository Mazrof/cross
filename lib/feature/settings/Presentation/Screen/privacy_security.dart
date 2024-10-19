import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';

class PrivacySecurityScreen extends StatelessWidget {
  final bool readReceiptStatus;
  const PrivacySecurityScreen({super.key, required this.readReceiptStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Privacy And Security"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.timer_outlined),
            title: Text('Auto-Delete Messages'),
            subtitle: Text('2'),
            onTap: () {
              context.go(AppRouter.kautoDeleteMessages);
            },
          ),
          ListTile(
            leading: Icon(Icons.back_hand_outlined),
            title: Text('Blocked Users'),
            subtitle: Text('2'),
            onTap: () {
              context.go(AppRouter.kblockedUsers);
            },
          ),
          ListTile(
            leading: Icon(Icons.devices_rounded),
            title: Text('Devices'),
            subtitle: Text('5'),
            onTap: () {},
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Privacy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          ListTile(
            title: Text('Last Seen & Online'),
            subtitle: Text('Everybody'),
            onTap: () {
              context.go(AppRouter.klastSeenOnline);
            },
          ),
          ListTile(
            title: Text('Profile Photos'),
            subtitle: Text('Everybody'),
            onTap: () {
              context.go(AppRouter.kprofilePhotoSecurity);
            },
          ),
          SwitchListTile(
            title: Text('Enable Read Receipts'),
            activeColor: Colors.lightBlue,
            value: readReceiptStatus,
            onChanged: (bool newValue) {},
          ),
        ],
      ),
    );
  }
}
