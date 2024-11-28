import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class NewChannelScreen extends StatelessWidget {
  NewChannelScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: const Text("New Channel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppSizes.iconXlg,
                  height: AppSizes.iconXlg,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.photo, color: Colors.white),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                ),
                const SizedBox(
                  width: AppSizes.sm,
                ),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Channel Name",
                      hintStyle: TextStyle(color: AppColors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: AppSizes.sm,
            ),
            const SizedBox(
              height: AppSizes.inputFieldH,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: AppColors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.sm,
            ),
            Text(
              "You can provide an optional description for your channel.",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}
