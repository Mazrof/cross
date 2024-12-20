import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/privacy_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/privacy_state.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyCubit, PrivacyState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          // return LogoLoader();
        } else if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return PrivacySecurityPage(state: state);
        }
        return PrivacySecurityPage(state: state);
      },
    );
  }
}

class PrivacySecurityPage extends StatelessWidget {
  final PrivacyState state;
  const PrivacySecurityPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          title: const Text(
            AppStrings.privacyAndSecurity,
          ),
          leadingIcon: Icons.arrow_back,
          onLeadingTap: () {
            context.go(AppRouter.ksettings);
          }),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.security,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: Text(
              AppStrings.autoDelMessages,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.autoDeleteTimer,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.kautoDeleteMessages);
            },
          ),
          ListTile(
            leading: const Icon(Icons.back_hand_outlined),
            title: Text(
              AppStrings.blockedUsers,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              context.go(AppRouter.kblockedUsers);
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices_rounded),
            title: Text(
              AppStrings.devices,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              '5',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.privacy,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: Text(
              AppStrings.lastSeenOnline,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.lastSeenPrivacy,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.klastSeenOnline);
            },
          ),
          ListTile(
            title: Text(
              AppStrings.profilePhotos,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.profilePhotoPrivacy,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.kprofilePhotoSecurity);
            },
          ),
          ListTile(
            title: Text(
              AppStrings.storyVisibility,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.storyVisibility,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.kstoryVisibility);
            },
          ),
          ListTile(
            title: Text(
              AppStrings.readReceipts,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              state.enableReadReceipt,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              context.go(AppRouter.kreadReceiptSetting);
            },
          ),
        ],
      ),
    );
  }
}
