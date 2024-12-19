import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_state.dart';
import 'package:telegram/feature/groups/group_setting/presentation/widget/shimmer_loading_widget._group_setting.dart';
import 'package:telegram/feature/home/presentation/screen/home_screen.dart';

class GroupSettingsScreen extends StatelessWidget {
  final int groupId;

  const GroupSettingsScreen({Key? key, required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user_id = HiveCash.read(boxName: 'register_info', key: 'id');
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          Navigator.of(context).pop();
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              if (user_id ==
                      sl<GroupCubit>()
                          .state
                          .members
                          .firstWhere((element) => element.role == 'admin')
                          .userId &&
                  sl<GroupCubit>().state.members.length == 1) {
                CSnackBar.showErrorDialog(context,
                    'Group will be deleted if you did not set another admin',
                    () {
                  sl<GroupCubit>().deleteGroup(groupId);

                  GoRouter.of(context).pop();
                });
                return;
              } else {
                CSnackBar.showErrorDialog(
                    context, 'are you sure you want to leave group', () {
                  sl<GroupCubit>().leaveGroup(groupId,
                      HiveCash.read(boxName: 'register_info', key: 'id'));

                  GoRouter.of(context).pop();
                });
              }
              GoRouter.of(context).pop();
            },
          ),
          if (sl<GroupCubit>()
                  .state
                  .members
                  .firstWhere((element) => element.role == 'admin')
                  .userId ==
              user_id)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                CSnackBar.showErrorDialog(
                    context, 'Are you sure you want to delete this group?', () {
                  sl<GroupCubit>().deleteGroup(groupId);
                  GoRouter.of(context).pop();
                });
              },
            ),
        ],
      ),
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          if (state.state == CubitState.loading) {
            return ShimmerLoadingWidget();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                color: AppColors.primaryColor,
                child: Row(
                  children: [
                    GeneralImage(username: state.group!.name, imageUrl: ""),
                    const SizedBox(width: AppSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.group!.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          '${state.group!.groupSize} Members',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Group Information
              SizedBox(
                height: 20,
              ),

              SwitchListTile(
                activeColor: AppColors.primaryColor,
                activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                inactiveThumbColor: AppColors.grey,
                inactiveTrackColor: AppColors.grey.withOpacity(0.5),
                title: Text(
                  'Mute Notifications',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value:
                    state.ismute, // This should reflect the current mute state
                onChanged: (value) {
                  sl<GroupCubit>().toggleNotifications(groupId, value);
                },
              ),
              if (user_id ==
                  sl<GroupCubit>()
                      .state
                      .members
                      .firstWhere((element) => element.role == 'admin')
                      .userId)
                Column(
                  children: [
                    const Divider(),
                    SwitchListTile(
                      activeColor: AppColors.primaryColor,
                      activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                      inactiveThumbColor: AppColors.grey,
                      inactiveTrackColor: AppColors.grey.withOpacity(0.5),
                      title: Text(
                        'make it private',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: state.group!.privacy, //TODO: Get value from cubit
                      onChanged: (value) {
                        sl<GroupCubit>().togglePrivacy(groupId, value);
                      },
                    ),
                  ],
                ),
              if (user_id ==
                  sl<GroupCubit>()
                      .state
                      .members
                      .firstWhere((element) => element.role == 'admin')
                      .userId)
                Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextButton.icon(
                        onPressed: () {
                          GoRouter.of(context)
                              .push(AppRouter.kAddmembers, extra: state.group);
                        },
                        icon: const Icon(Icons.add,
                            color: AppColors.primaryColor),
                        label: const Text(
                          'Add Member',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              const Divider(),
              // Members List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('    Group Members',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                          )),
                  ...state.members.map((member) {
                    return ListTile(
                      leading: GeneralImage(
                          username: member.username, imageUrl: member.imageUrl),
                      title: Text(member.username,
                          style: Theme.of(context).textTheme.bodyMedium),
                      subtitle: Text(member.role,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.grey,
                                  )),
                      trailing: user_id ==
                              sl<GroupCubit>()
                                  .state
                                  .members
                                  .firstWhere(
                                      (element) => element.role == 'admin')
                                  .userId
                          ? PopupMenuButton<String>(
                              color: const Color.fromARGB(255, 198, 217, 238),
                              onSelected: (value) {
                                if (value == 'editPermissions') {
                                  GoRouter.of(context).push(
                                      AppRouter.kUserPermission,
                                      extra: member);
                                } else if (value == 'remove') {
                                  sl<GroupCubit>()
                                      .removeMember(groupId, member.userId);
                                } else if (value == 'admin') {
                                  sl<GroupCubit>().updateMemberRole(
                                    MemberModel(
                                        userId: member.userId,
                                        role: 'admin',
                                        hasDownloadPermissions:
                                            member.hasDownloadPermissions,
                                        hasMessagePermissions:
                                            member.hasMessagePermissions),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'editPermissions',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Edit Permissions'),
                                      ],
                                    )),
                                const PopupMenuItem(
                                    value: 'remove',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Remove Member'),
                                      ],
                                    )),
                                const PopupMenuItem(
                                    value: 'admin',
                                    child: Row(
                                      children: [
                                        Icon(Icons.star),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('set admin'),
                                      ],
                                    )),
                              ],
                            )
                          : Container(),
                    );
                  }).toList()
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
