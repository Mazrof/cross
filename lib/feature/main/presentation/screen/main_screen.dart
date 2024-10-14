import 'package:flutter/material.dart';
import 'package:telegram/feature/main/presentation/widget/app_drawer.dart';
import 'package:telegram/core/component/contact_list/contact_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Center(child: Text("Telegram")),
      ),
      body: const ContactList(),
    );
  }
}
