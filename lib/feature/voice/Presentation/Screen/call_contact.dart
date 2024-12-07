import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/contact_list/contact_list.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class CallContactScreen extends StatelessWidget {
  const CallContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.kcallLog);
        },
        title: const Text(AppStrings.selectContact),
      ),
      body: const ContactList(
       
      ),
    );
  }
}
