import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/contact_list/contact_list.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/contacts/presentation/widget/custom_tile.dart';

class ContactsScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          onLeadingTap: () {
            context.go(AppRouter.kHome);
          },
          showBackButton: true,
          title: const Text(
            "Contacts",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // to be implemented
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  // to be implemented
                },
                icon: const Icon(Icons.sort)),
          ]),
      body: ListView(children: [
        CustomTile(
          title: "New Group",
          icon: Icons.group,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kNewGroup);
          },
        ),
        CustomTile(
          title: "New Contact",
          icon: Icons.add,
          onPressed: () {
            _showModalBottomSheet(context);
          },
        ),
        CustomTile(
          title: "New Channel",
          icon: Icons.group_work,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kNewChannel);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Text(
            "Sorted by last seen time",
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: AppColors.grey),
          ),
        ),
        const ContactList()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => _showModalBottomSheet(context),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.person_add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('New Contact',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'First name (required)',
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Last name (optional)',
                  ),
                ),
                const SizedBox(height: 10),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber value) {},
                  selectorConfig: const SelectorConfig(
                    showFlags: true,
                  ),
                  textFieldController: controller,
                  autoValidateMode: AutovalidateMode.always,
                ),
                // const TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Phone number',
                //     prefixIcon: Icon(Icons.flag),
                //     prefixText: '+20 ',
                //   ),
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Create Contact'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
