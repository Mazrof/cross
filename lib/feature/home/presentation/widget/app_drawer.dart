import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class CAppDrawer extends StatelessWidget {
  const CAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            accountName: Text(
              'Your Name',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
            ),
            accountEmail: Text(
              'your.email@example.com',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
            ),
            currentAccountPicture:
                Avatar(imageUrl: AppAssetsStrings.general_person),
          ),
          DrawerListTile(
            iconData: Icons.group,
            title: 'New Group',
            onTilePressed: () {
              context.go(AppRouter.kNewGroup);
            },
          ),
          DrawerListTile(
            iconData: Icons.lock,
            title: 'New Secret Chat',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.notifications,
            title: 'New Channel',
            onTilePressed: () {
              context.go(AppRouter.kNewChannel);
            },
          ),
          DrawerListTile(
            iconData: Icons.person,
            title: 'Contacts',
            onTilePressed: () {
              context.go(AppRouter.kContacts);
            },
          ),
          DrawerListTile(
            iconData: Icons.phone,
            title: 'Calls',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.bookmark,
            title: 'Saved Messages',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.settings,
            title: 'Settings',
            onTilePressed: () {
              context.go(AppRouter.ksettings);
            },
          ),
          const Divider(),
          DrawerListTile(
            iconData: Icons.person_add,
            title: 'Invite Friends',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.help_outline,
            title: 'Telegram FAQ',
            onTilePressed: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
