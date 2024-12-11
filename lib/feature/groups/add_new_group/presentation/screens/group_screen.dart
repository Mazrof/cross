import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({required this.groupData});
  final GroupsModel groupData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: GestureDetector(
          child: Row(
            children: [
              GeneralImage(
                username: groupData.name,
                imageUrl: 'https://via.placeholder.com/150',
              ),
              Column(
                children: [
                  Text(groupData.name,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          onTap: () {
            GoRouter.of(context).push(AppRouter.kGroupSetting);
          },
        ),
      ),
      body: const Center(
        child: Text('Group Screen'),
      ),
    );
  }
}
