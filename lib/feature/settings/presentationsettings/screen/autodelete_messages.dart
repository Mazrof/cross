import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:telegram/feature/settings/presentationsettings/widget/radio_tile.dart';

class AutodelMessagesScreen extends StatelessWidget {
  const AutodelMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return AutodelMessages(state: state);
        }
        return AutodelMessages(state: state);
      },
    );
  }
}

class AutodelMessages extends StatelessWidget {
  // final AutoDelOption selectedTimer;
  final UserSettingsState state;
  const AutodelMessages({super.key, required this.state});

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
        value!,
        state.lastSeenPrivacy,
        state.profilePhotoPrivacy,
        state.enableReadReceipt,
      );
      cubit.loadSettings();
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text(AppStrings.autoDelMessages),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kprivacyAndSecurity);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Center(
            child: Icon(
              Icons.security,
              size: 80,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.selfDestructTimer,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              RadioTile(
                  onChanged: saveSettings,
                  state: state,
                  label: AppStrings.off,
                  groupValue: state.autoDeleteTimer),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  onChanged: saveSettings,
                  state: state,
                  label: AppStrings.afterOneDay,
                  groupValue: state.autoDeleteTimer),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  onChanged: saveSettings,
                  state: state,
                  label: AppStrings.afterOneWeek,
                  groupValue: state.autoDeleteTimer),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  onChanged: saveSettings,
                  state: state,
                  label: AppStrings.afterOneMonth,
                  groupValue: state.autoDeleteTimer),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'If enabled, all new messages in chats you start will be automatically deleted for everyone at some point after they are sent.',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
