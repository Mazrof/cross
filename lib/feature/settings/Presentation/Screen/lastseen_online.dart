import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../Widget/radio_tile.dart';

class LastseenOnlineScreen extends StatelessWidget {
  final PrivacyOption selectedOption;
  const LastseenOnlineScreen({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
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
                label: AppStrings.everybody,
                groupValue: selectedOption.convertString()),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                label: AppStrings.myContacts,
                groupValue: selectedOption.convertString()),
            const Divider(
              thickness: 0.5,
            ),
            RadioTile(
                label: AppStrings.nobody,
                groupValue: selectedOption.convertString()),
          ],
        ),
      ]),
    );
  }
}
