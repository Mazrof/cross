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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const LogoLoader();
        } else if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return SettingsPage(state: state);
        }
        return SettingsPage(state: state);
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  final UserSettingsState state;

  const SettingsPage({required this.state, super.key});

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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(state.profileImage),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.screenName,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.status,
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              AppStrings.account,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: Text(
              AppStrings.phoneNumber,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.phoneNumber,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          ListTile(
            title: Text(
              AppStrings.username,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.userName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          ListTile(
            title: Text(
              AppStrings.bio,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.bio,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.keditProfile);
            },
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              AppStrings.settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded),
            title: Text(
              AppStrings.privacyAndSecurity,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              context.go(AppRouter.kprivacyAndSecurity);
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices_rounded),
            title: Text(
              AppStrings.devices,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
