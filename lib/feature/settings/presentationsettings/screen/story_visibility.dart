import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/block_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/block_state.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/privacy_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/privacy_state.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:telegram/feature/settings/presentationsettings/widget/radio_tile.dart';

class StoryVisibilityScreen extends StatelessWidget {
  const StoryVisibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyCubit, PrivacyState>(
      builder: (context, state) {
        if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return StoryVisibilityPage(state: state);
        }
        return StoryVisibilityPage(state: state);
      },
    );
  }
}

class StoryVisibilityPage extends StatelessWidget {
  final PrivacyState state;
  const StoryVisibilityPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    void saveSettings(String? value) async {
      final cubit = context.read<PrivacyCubit>();
      await cubit.updatePrivacySettings(newStoryVisibility: value);
      cubit.loadPrivacySettings();
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text(AppStrings.storyVisibility),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kprivacyAndSecurity);
        },
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        Text(
          AppStrings.storyVisibility,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.everybody,
                groupValue: state.storyVisibility),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.myContacts,
                groupValue: state.storyVisibility),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                onChanged: saveSettings,
                state: state,
                label: AppStrings.nobody,
                groupValue: state.storyVisibility),
          ],
        ),
      ]),
    );
  }
}
