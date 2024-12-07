import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart'; // Import the cubit

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  _GroupInfoState createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage; // Store the selected image as a File

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
      body: BlocBuilder<AddMembersCubit, AddMembersState>(
        builder: (context, state) {
          if (state.state == CubitState.loading) {
            return const Center(child: LogoLoader());
          }

          if (state.state == CubitState.failure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CSnackBar.showErrorSnackBar(
                  context, 'Error', state.errorMessage ?? 'An error occurred');
            });
          }
          if (state.state == CubitState.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).go(AppRouter.kGroupScreen,
                  extra: sl<AddMembersCubit>().state.group);
            });
          }

          return Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              children: [
                // Group photo section
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Group image container
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            _selectedImage = File(pickedFile.path);
                          });
                          sl<AddMembersCubit>()
                              .setGroupImageUrl(pickedFile.path);
                          CSnackBar.showSuccessSnackBar(
                              context, 'Success', 'Image uploaded');
                        }
                      },
                      child: Container(
                        width: AppSizes.iconXlg,
                        height: AppSizes.iconXlg,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: _selectedImage == null
                            ? const Icon(Icons.photo, color: Colors.white)
                            : ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: AppSizes.iconXlg,
                                  height: AppSizes.iconXlg,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),

                    // Group name input field
                    Expanded(
                      child: TextField(
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
                        onChanged: (value) {
                          sl<AddMembersCubit>().setGroupName(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.md),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          sl<AddMembersCubit>().createGroup();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
