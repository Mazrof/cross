import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/helper/screen_helper.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onButtonPressed});

  final String title;
  final String subtitle;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //image
            Image.asset(
              'assets/gif/success.gif',
              width: ScreenHelper.getScreenWidth(context),
              height: ScreenHelper.getScreenHeight(context),
            ),

            //title and subtitl
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizes.spaceBetweenSections / 2,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: AppSizes.spaceBetweenSections,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                child: const Text(AppStrings.tcontinue),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
