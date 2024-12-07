import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_state.dart';

class EditPermissionsScreen extends StatelessWidget {
  final MembershipModel member;

  const EditPermissionsScreen({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: const Text('Edit Permissions'),
      ),
      body: BlocBuilder<PermisionCubit, PermisionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GeneralImage(
                      username: state.membershipModel!.username,
                      imageUrl: state.membershipModel!.imageUrl,
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.membershipModel!.username,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  'Download Permissions',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RadioListTile<bool>(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Allow',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: true,
                  groupValue: state.membershipModel!.hasDownloadPermissions,
                  onChanged: (value) {
                    context
                        .read<PermisionCubit>()
                        .toggleDownloadPermissions(value!);
                  },
                ),
                RadioListTile<bool>(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Disallow',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: false,
                  groupValue: state.membershipModel!.hasDownloadPermissions,
                  onChanged: (value) {
                    context
                        .read<PermisionCubit>()
                        .toggleDownloadPermissions(value!);
                  },
                ),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Message Permissions',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                RadioListTile<bool>(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Allow',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: true,
                  groupValue: state.membershipModel!.hasMessagePermissions,
                  onChanged: (value) {
                    context
                        .read<PermisionCubit>()
                        .toggleMessagePermissions(value!);
                  },
                ),
                RadioListTile<bool>(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Disallow',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: false,
                  groupValue: state.membershipModel!.hasMessagePermissions,
                  onChanged: (value) {
                    context
                        .read<PermisionCubit>()
                        .toggleMessagePermissions(value!);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<PermisionCubit>();
          // cubit.editMemberData(
          //   hasDownloadPermissions:
          //       cubit.state.membershipModel.hasDownloadPermissions,
          //   hasMessagePermissions:
          //       cubit.state.membershipModel.hasMessagePermissions,
          // );
          GoRouter.of(context).pop();
        },
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
