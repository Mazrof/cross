import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';

// will edit UI
class SettingsScreen extends StatelessWidget {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;

  const SettingsScreen(
      {super.key,
      required this.screenName,
      required this.userName,
      required this.phoneNumber,
      required this.bio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'change_picture') {
                  } else if (value == 'edit_profile') {
                    context.go(AppRouter.keditProfile);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'change_picture',
                      child: Text('Change Profile Picture'),
                    ),
                    PopupMenuItem<String>(
                      value: 'edit_profile',
                      child: Text('Edit info'),
                    )
                  ];
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(screenName),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/chat_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(phoneNumber),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Username'),
                  subtitle: Text(userName),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Bio'),
                  subtitle: Text(bio),
                  onTap: () {
                    context.go(AppRouter.keditProfile);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Privacy and Security'),
                  onTap: () {
                    context.go(AppRouter.kprivacyAndSecurity);
                  },
                ),
                ListTile(
                  title: Text('Devices'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
