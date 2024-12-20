import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return LogoLoader();
        } else if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        return EditProfilePage(
          state: state,
        );
      },
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key, required this.state});
  final UserSettingsState state;

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController(text: state.userName);
    final screenNameController = TextEditingController(text: state.screenName);
    final bioController = TextEditingController(text: state.bio);
    final phoneNumberController =
        TextEditingController(text: state.phoneNumber);

    void saveSettings() async {
      final cubit = context.read<UserSettingsCubit>();

      await cubit.saveSettings(
        newScreenName: screenNameController.text,
        newUserName: userNameController.text,
        newPhoneNumber: phoneNumberController.text,
        newBio: bioController.text,
      );
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text(AppStrings.profileInfo),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.ksettings);
        },
        actions: [
          IconButton(
              onPressed: () {
                saveSettings();
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.yourUsername,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                hintText: AppStrings.enterYourUsername,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.yourName,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: screenNameController,
              decoration: const InputDecoration(
                hintText: AppStrings.enterYourName,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.yourBio,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: bioController,
              maxLength: 70,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: AppStrings.bioHint,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.bioDescription,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              AppStrings.phoneNumber,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneNumberController,
              maxLength: 13,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
