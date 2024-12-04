import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart'; // Import the cubit

class GroupInfo extends StatefulWidget {
  GroupInfo({super.key});

  @override
  _GroupInfoState createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: const Text("New Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            // Group photo section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<AddMembersCubit, AddMembersState>(
                  builder: (context, state) {
                    return state.groupImageUrl == null
                        ? Container(
                            width: AppSizes.iconXlg,
                            height: AppSizes.iconXlg,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: IconButton(
                              icon:
                                  const Icon(Icons.photo, color: Colors.white),
                              onPressed: () async {
                                final pickedFile = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  // Update the state with the selected image URL
                                  context
                                      .read<AddMembersCubit>()
                                      .setGroupImageUrl(pickedFile.path);

                                  CSnackBar.showSuccessSnackBar(
                                      context, 'success', 'image uploaded');
                                }
                              },
                            ))
                        : ClipOval(
                            child: Image.file(
                              File(state.groupImageUrl!),
                              fit: BoxFit.cover,
                            ),
                          );
                  },
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: BlocBuilder<AddMembersCubit, AddMembersState>(
                    builder: (context, state) {
                      _nameController.text =
                          state.groupName; // Set the text field value
                      return TextField(
                        controller: _nameController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          hintText: "Group Name",
                          hintStyle: TextStyle(color: AppColors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          // Save the group name and image URL to the state
          if (_nameController.text.isEmpty) {
            CSnackBar.showErrorSnackBar(
                context, 'error', 'Group name is required');
            return;
          } else {
            context.read<AddMembersCubit>().setGroupName(_nameController.text);
          }
          
          // Add group creation logic here
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
