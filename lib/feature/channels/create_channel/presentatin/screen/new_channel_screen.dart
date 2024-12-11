import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_cubit.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_state.dart';

class NewChannelScreen extends StatelessWidget {
  NewChannelScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          // context.go(AppRouter.kHome);
          GoRouter.of(context).pop();
        },
        title: const Text("New Channel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<AddChannelCubit, AddChannelState>(
          builder: (context, state) {
        if (state.state == CubitState.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Channel created successfully!')),
          );
          Navigator.of(context).pop();
        } else if (state.state == CubitState.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error occurred')),
          );
        }
        return Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: AppSizes.iconXlg,
                      height: AppSizes.iconXlg,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.photo, color: Colors.white),
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.sm,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: "Channel Name",
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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSizes.sm,
                ),
              ],
            ));
      }),
    );
  }
}
