import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
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
          return LogoLoader();
        } else if (state.currState == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Groups'),
          ),
          body: ListView.builder(
            itemCount: state.groups.length,
            itemBuilder: (context, index) {
              final group = state.groups[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    child: Text(group.name[0].toUpperCase()),
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Privacy: ${group.privacy ? 'Private' : 'Public'}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: group.status
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : IconButton(
                          icon:
                              const Icon(Icons.filter_alt, color:AppColors.primaryColor),
                          onPressed: () {
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
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
