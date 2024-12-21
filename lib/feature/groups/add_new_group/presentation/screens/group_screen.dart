import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({required this.groupData});
  final GroupModel groupData;

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
                imageUrl: groupData.imageUrl??"",
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
            GoRouter.of(context)
                .push(AppRouter.kGroupSetting, extra: groupData.id);
          },
        ),
      ),
      body: const Center(
        child: Text('Group Screen'),
      ),
    );
  }
}
