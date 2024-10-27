import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class PrivacySecurityScreen extends StatelessWidget {
  final bool readReceiptStatus;
  const PrivacySecurityScreen({super.key, required this.readReceiptStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          title: const Text(AppStrings.privacyAndSecurity),
          leadingIcon: Icons.arrow_back,
          onLeadingTap: () {
            context.go(AppRouter.ksettings);
          }),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppStrings.security,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text(AppStrings.autoDelMessages),
            subtitle: const Text('2'),
            onTap: () {
              context.go(AppRouter.kautoDeleteMessages);
            },
          ),
          ListTile(
            leading: const Icon(Icons.back_hand_outlined),
            title: const Text(AppStrings.blockedUsers),
            subtitle: const Text('2'),
            onTap: () {
              context.go(AppRouter.kblockedUsers);
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices_rounded),
            title: const Text(AppStrings.devices),
            subtitle: const Text('5'),
            onTap: () {},
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppStrings.privacy,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          ListTile(
            title: const Text(AppStrings.lastSeenOnline),
            subtitle: const Text('Everybody'),
            onTap: () {
              context.go(AppRouter.klastSeenOnline);
            },
          ),
          ListTile(
            title: const Text(AppStrings.profilePhotos),
            subtitle: const Text('Everybody'),
            onTap: () {
              context.go(AppRouter.kprofilePhotoSecurity);
            },
          ),
          SwitchListTile(
            title: const Text(AppStrings.enableReadReceipts),
            activeColor: Colors.lightBlue,
            value: readReceiptStatus,
            onChanged: (bool newValue) {},
          ),
        ],
      ),
    );
  }
}
