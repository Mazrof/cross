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
import 'package:telegram/feature/settings/presentationsettings/widget/radio_tile.dart';

class LastseenOnlineScreen extends StatelessWidget {
  const LastseenOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return LastseenOnlinePage(state: state);
        }
        return LastseenOnlinePage(state: state);
      },
    );
  }
}

class LastseenOnlinePage extends StatelessWidget {
  // final PrivacyOption selectedOption;
  final UserSettingsState state;
  const LastseenOnlinePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    void saveSettings(String? value) async {
      final cubit = context.read<UserSettingsCubit>();
      await cubit.saveSettings(
        state.screenName,
        state.userName,
        state.phoneNumber,
        state.bio,
        "Online",
        state.autoDeleteTimer,
        value!,
        state.profilePhotoPrivacy,
        state.enableReadReceipt,
      );
      cubit.loadSettings();
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text(AppStrings.lastSeenOnline),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kprivacyAndSecurity);
        },
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        Text(
          AppStrings.lastSeenTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.everybody,
                groupValue: state.lastSeenPrivacy),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.myContacts,
                groupValue: state.lastSeenPrivacy),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.nobody,
                groupValue: state.lastSeenPrivacy),
          ],
        ),
      ]),
    );
  }
}
