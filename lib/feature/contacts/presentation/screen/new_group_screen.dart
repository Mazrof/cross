import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/contact_list/contact_list.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class NewGroupScreen extends StatelessWidget {
  const NewGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {
          context.go(AppRouter.kHome);
          // GoRouter.of(context).pop();
        },
        leadingIcon: Icons.arrow_back,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("New Group"),
            Text(
              "up to 200000 members",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(AppSizes.sm),
            child: Text(
              "Who would you like to add?",
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          ContactList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(
          Icons.arrow_forward,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
