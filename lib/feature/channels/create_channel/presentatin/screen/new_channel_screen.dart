import 'dart:io';

import 'package:flutter/material.dart';
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
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_cubit.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_state.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart';

class NewChannelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddChannelCubit, AddChannelState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const LogoLoader();
        } else if (state.state == CubitState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).pop();

            GoRouter.of(context).pushReplacement(AppRouter.kChannelScreen,
                extra: sl<AddChannelCubit>().state.channel);
          });
        } else if (state.state == GroupStatus.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(
                context, 'Error', state.errorMessage ?? 'An error occurred');
          });
          print("here");
        }

        return ChannelInfoPage();
      },
    );
  }
}

class ChannelInfoPage extends StatelessWidget {
  const ChannelInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AddChannelCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: const Text("New channel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => cubit.selectChannelImage(),
                    child: Container(
                      width: AppSizes.iconXlg,
                      height: AppSizes.iconXlg,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: state.channelImageUrl == null
                          ? const Icon(Icons.photo, color: Colors.white)
                          : ClipOval(
                              child: Image.file(
                                File(state.channelImageUrl!),
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
                      onChanged: cubit.setChannelName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Channel Type',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: const Text('Public Channel'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: state.privacy,
                      onChanged: (value) =>
                          sl<AddChannelCubit>().setChannelPrivacy(value!),
                    ),
                  ),
                  ListTile(
                    title: const Text('Private Channel'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: state.privacy,
                      onChanged: (value) =>
                          sl<AddChannelCubit>().setChannelPrivacy(value!),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.privacy)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Public Link',
                            prefixText: 't.me/',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'If you set a public link, other people will be able to find and join your channel.\nYou can use a–z, 0–9, and underscores. Minimum length is 5 characters.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: cubit.createChannel,
        child: const Icon(Icons.check),
      ),
    );
  }
}
