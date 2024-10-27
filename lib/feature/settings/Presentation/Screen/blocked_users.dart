import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/contact_list/contact_list_tile.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class BlockedUsersScreen extends StatelessWidget {
  final List<String> blockedUsers;
  const BlockedUsersScreen({super.key, required this.blockedUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: const Text(AppStrings.blockedUsers),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kprivacyAndSecurity);
        },
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_add_alt),
            title: const Text(
              AppStrings.blockUser,
              style: TextStyle(color: Colors.lightBlue),
            ),
            onTap: () {
              context.go(AppRouter.kblockUser);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              AppStrings.blockDescription,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              '${blockedUsers.length} ${AppStrings.blockedUsers}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: blockedUsers.map((blockedUser) {
                return ContactListTile(
                  imageUrl:
                      "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
                  contactName: blockedUser,
                  lastMessage: "Hello",
                );
              }).toList(),
              //Can use onLongtap or popupmenubutton to block user
            ),
          ),
        ],
      ),
    );
  }
}
