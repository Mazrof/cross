import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

// will edit UI
class SettingsScreen extends StatelessWidget {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;

  const SettingsScreen(
      {super.key,
      required this.screenName,
      required this.userName,
      required this.phoneNumber,
      required this.bio,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {},
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage("assets/images/chat_background.png"),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      screenName,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      status,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit_profile') {
                context.go(AppRouter.keditProfile);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit_profile',
                  child: Text(AppStrings.editInfo),
                )
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              AppStrings.account,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          ListTile(
            title: const Text(AppStrings.phoneNumber),
            subtitle: Text(phoneNumber),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          ListTile(
            title: const Text(AppStrings.username),
            subtitle: Text(userName),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          ListTile(
            title: const Text(AppStrings.bio),
            subtitle: Text(bio),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          Container(
            width: 10,
            height: 10,
            color: Colors.grey[300],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              AppStrings.settings,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded),
            title: const Text(AppStrings.privacyAndSecurity),
            onTap: () {
              context.go(AppRouter.kprivacyAndSecurity);
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices_rounded),
            title: const Text(AppStrings.devices),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
