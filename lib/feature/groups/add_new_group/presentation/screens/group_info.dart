import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';

class GroupInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMembersCubit, AddMembersState>(
      builder: (context, state) {
        if (state.state == GroupStatus.loadinginfo) {
          return const LogoLoader();
        } else if (state.state == GroupStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print(sl<AddMembersCubit>().state.group);
            GoRouter.of(context).pop();

            GoRouter.of(context).pushReplacement(AppRouter.kGroupScreen,
                extra: GroupModel(
                    groupSize: state.group!.groupSize,
                    name: state.group!.name,
                    id: state.group!.id,
                    privacy: state.group!.privacy,
                    imageUrl: ""));
          });
        } else if (state.state == GroupStatus.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(
                context, 'Error', state.errorMessage ?? 'An error occurred');
          });
          print("here");
        }

        return GroupInfoPage();
      },
    );
  }
}

class GroupInfoPage extends StatelessWidget {
  const GroupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AddMembersCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: const Text("New Group"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => cubit.selectGroupImage(),
                    child: Container(
                      width: AppSizes.iconXlg,
                      height: AppSizes.iconXlg,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: state.groupImageUrl == null
                          ? const Icon(Icons.photo, color: Colors.white)
                          : ClipOval(
                              child: Image.file(
                                File(state.groupImageUrl!),
                                fit: BoxFit.cover,
                                width: AppSizes.iconXlg,
                                height: AppSizes.iconXlg,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: TextField(
                      controller: cubit.nameController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        hintText: "Group Name",
                        hintStyle: TextStyle(color: AppColors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      onChanged: cubit.setGroupName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.xl),
              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: cubit.sizeController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: "Group Size",
                  hintStyle: TextStyle(color: AppColors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onChanged: cubit.setGroupSize,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: cubit.createGroup,
        child: const Icon(Icons.check),
      ),
    );
  }
}
