import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:telegram/feature/settings/presentationsettings/widget/radio_tile.dart';

class ProfilePhotoSecurityScreen extends StatelessWidget {
  const ProfilePhotoSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        return ProfilePhotoSecurityPage(
          state: state,
        );
      },
    );
  }
}

class ProfilePhotoSecurityPage extends StatelessWidget {
  final UserSettingsState state;
  const ProfilePhotoSecurityPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    void saveSettings(String? value) async {
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
          value!,
          state.enableReadReceipt,
          state.blockedUsers,
          state.contacts);
      cubit.loadSettings();
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text(
          AppStrings.profilePhotos,
        ),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kprivacyAndSecurity);
        },
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        Text(
          AppStrings.profilePhotosTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.everybody,
                groupValue: state.profilePhotoPrivacy),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.myContacts,
                groupValue: state.profilePhotoPrivacy),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.nobody,
                groupValue: state.profilePhotoPrivacy),
          ],
        )
      ]),
    );
  }
}
