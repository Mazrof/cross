import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state.currState == CubitState.loading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GroupsContent(
              state: state,
            ),
          );
        } else if (state.currState == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        return Scaffold(
          body: GroupsContent(
            state: state,
          ),
        );
      },
    );
  }
}

class GroupsContent extends StatelessWidget {
  const GroupsContent({
    required this.state,
    super.key,
  });
  final state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.groups.length,
      itemBuilder: (context, index) {
        final group = state.groups[index];
        return Card(
          surfaceTintColor: AppColors.primaryColor,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                child: Text(group.id.toUpperCase()),
              ),
              title: Text(
                group.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group Size: ${group.groupSize}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.grey),
                  ),
                  Text(
                    'Privacy: ${group.privacy ? 'Private' : 'Public'}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              trailing: group.hasFilter
                  ? TextButton(
                      onPressed: () {
                        sl<GroupsCubit>().filterGroups(group.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Filter applied to group ${group.name}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(.5),
                          ),
                        );
                      },
                      child: Text(
                        'Remove Filter',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.primaryColor),
                      ))
                  : SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            sl<GroupsCubit>().filterGroups(group.id);
                            // Handle filter action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Filter applied to group ${group.name}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(.5),
                              ),
                            );
                          },
                          child: Text(
                            'Filter',
                          )),
                    )),
        );
      },
    );
  }
}
