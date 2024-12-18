import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/channels/channel_setting/presentation/controller/channel_setting_cubit.dart';
import 'package:telegram/feature/channels/channel_setting/presentation/controller/channel_setting_state.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/widget/shimmer_loading_widget._group_setting.dart';

class ChannelSettingScreen extends StatelessWidget {
  final int channelId;

  const ChannelSettingScreen({super.key, required this.channelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          Navigator.of(context).pop();
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to Edit Group Screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              CSnackBar.showErrorDialog(
                  context, 'Are you sure you want to delete this group?', () {
                sl<GroupCubit>().deleteGroup(channelId);
                GoRouter.of(context).pop();
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ChannelSettingCubit, ChannelSettingState>(
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
                    GeneralImage(username: state.channel!.name, imageUrl: ""),
                    const SizedBox(width: AppSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.channel!.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                    state.isMuted, // This should reflect the current mute state
                onChanged: (value) {
                  sl<GroupCubit>().toggleNotifications(channelId, value);
                },
              ),
              const Divider(),
              SwitchListTile(
                activeColor: AppColors.primaryColor,
                activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                inactiveThumbColor: AppColors.grey,
                inactiveTrackColor: AppColors.grey.withOpacity(0.5),
                title: Text(
                  ' private',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: state.channel!.privacy, //TODO: Get value from cubit
                onChanged: (value) {
                  sl<GroupCubit>().togglePrivacy(channelId, value);
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton.icon(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kAddMoreSubscribers,
                        extra: state.channel);
                  },
                  icon: const Icon(Icons.add, color: AppColors.primaryColor),
                  label: const Text(
                    'Add Member',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
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
                          username: member.username, imageUrl: member.imageURL),
                      title: Text(member.username,
                          style: Theme.of(context).textTheme.bodyMedium),
                      subtitle: Text(member.role,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.grey,
                                  )),
                      trailing: PopupMenuButton<String>(
                        color: const Color.fromARGB(255, 198, 217, 238),
                        onSelected: (value) {
                          if (value == 'editPermissions') {
                            GoRouter.of(context)
                                .push(AppRouter.kUserPermission, extra: member);
                          } else if (value == 'remove') {
                            sl<GroupCubit>()
                                .removeMember(channelId, member.userId);
                          } else if (value == 'admin') {
                            sl<GroupCubit>().updateMemberRole(
                              MemberModel(
                                userId: member.userId,
                                role: 'admin',
                                hasDownloadPermissions:
                                    member.hasDownloadPermissions,
                              ),
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
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
