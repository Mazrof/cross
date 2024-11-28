import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:telegram/feature/settings/presentationsettings/widget/contact_tile.dart';

class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return BlockUserPage(state: state);
        }
        return BlockUserPage(state: state);
      },
    );
  }
}

class BlockUserPage extends StatelessWidget {
  final UserSettingsState state;
  const BlockUserPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kblockedUsers);
        },
        title: const Text(AppStrings.blockUser),
      ),
      body: ListView(
        children: [
          ...state.contacts.map(
            (contact) {
              return ContactTile(
                imageUrl:
                    "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
                contactName: contact,
                onTap: () async {
                  var newBlockedList = List<String>.from(state.blockedUsers);
                  newBlockedList.add(contact);
                  var newContacts = List<String>.from(state.contacts);
                  newContacts.remove(contact);

                  final cubit = context.read<UserSettingsCubit>();
                  await cubit.saveSettings(
                    state.profileImage,
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
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
