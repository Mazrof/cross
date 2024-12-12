import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/component/shimmer.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_cubit.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_state.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/widget/chat_group_tile.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/widget/shimmer_loading_list.dart';

class AddNewSubscribersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("NewGroupScreen");
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        showBackButton: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("New Group"),
            Text(
              "up to 1000 members",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AddChannelCubit, AddChannelState>(
          builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const Center(
            child: ShimmerLoadingList(), // This widget will show shimmer effect
          );
        }

        return Column(
          children: [
            // Selected Members Section
            if (state.selectedSubscribers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100, // Constrain the height to avoid overflow
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.selectedSubscribers.length,
                    itemBuilder: (context, index) {
                      final member = state.selectedSubscribers[index];
                      return SizedBox(
                        width: 70,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                GeneralImage(
                                    username: member.name,
                                    imageUrl: member.imageUrl),
                                const SizedBox(height: 4),
                                Text(
                                  member.name,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            // Remove Button
                            Positioned(
                              top: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () {
                                  sl<AddMembersCubit>().toggleMember(member);
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            // Available Members List
            Expanded(
              child: ListView.builder(
                itemCount: state.allSubscribers.length,
                itemBuilder: (context, index) {
                  final member = state.allSubscribers[index];
                  final isSelected = state.selectedSubscribers.contains(member);

                  return ChatGroupTile(
                    id: member.id,
                    imageUrl: member.imageUrl,
                    title: member.name,
                    lastSeen: member.lastSeen,
                    onTap: () {
                      sl<AddMembersCubit>().toggleMember(member);
                    },
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kNewChannel);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
