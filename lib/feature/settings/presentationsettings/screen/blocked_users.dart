import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:telegram/feature/settings/presentationsettings/widget/contact_tile.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return BlockedUsersPage(state: state);
        }
        return BlockedUsersPage(state: state);
      },
    );
  }
}

class BlockedUsersPage extends StatelessWidget {
  // final List<String> blockedUsers;
  final UserSettingsState state;
  const BlockedUsersPage({super.key, required this.state});

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
              style: TextStyle(color: AppColors.lightBlueColor, fontSize: 18),
            ),
            onTap: () {
              context.go(AppRouter.kblockUser);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              AppStrings.blockDescription,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              '${(state.blockedUsers).length} ${AppStrings.blockedUsers}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          ...state.blockedUsers.map((blockedUser) {
            return ContactTile(
              imageUrl:
                  "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
              contactName: blockedUser,
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'unblock_user') {
                    var newBlockedList = List<String>.from(state.blockedUsers);
                    newBlockedList.remove(blockedUser);
                    var newContacts = List<String>.from(state.contacts);
                    newContacts.add(blockedUser);

                    final cubit = context.read<UserSettingsCubit>();
                    await cubit.saveSettings(
                      state.screenName,
                      state.userName,
                      state.phoneNumber,
                      state.bio,
                      "Online",
                      state.autoDeleteTimer,
                      state.lastSeenPrivacy,
                      state.profilePhotoPrivacy,
                      state.enableReadReceipt,
                      newBlockedList,
                      newContacts,
                    );

                    cubit.loadSettings();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'unblock_user',
                      child: Text("Unblock"),
                    )
                  ];
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
