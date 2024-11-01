import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                context.go(AppRouter.ksettings);
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
            const TextField(
              decoration: InputDecoration(
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
            const TextField(
              decoration: InputDecoration(
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
            const TextField(
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
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            )
          ],
        ),
      ),
    );
  }
}
