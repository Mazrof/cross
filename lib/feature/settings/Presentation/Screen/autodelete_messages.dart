import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../Widget/radio_tile.dart';

class AutodelMessages extends StatelessWidget {
  final AutoDelOption selectedTimer;
  const AutodelMessages({super.key, required this.selectedTimer});

  @override
  Widget build(BuildContext context) {
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
                  label: AppStrings.off,
                  groupValue: selectedTimer.convertString()),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: AppStrings.afterOneDay,
                  groupValue: selectedTimer.convertString()),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: AppStrings.afterOneWeek,
                  groupValue: selectedTimer.convertString()),
              const Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: AppStrings.afterOneMonth,
                  groupValue: selectedTimer.convertString()),
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
