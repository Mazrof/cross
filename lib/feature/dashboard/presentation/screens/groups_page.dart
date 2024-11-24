import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = [
      GroupModel(name: 'group1', id: 1),
      GroupModel(name: 'group2', id: 2),
      GroupModel(name: 'group3', id: 3),
      GroupModel(name: 'group4', id: 4),
      GroupModel(name: 'group5', id: 5),
      GroupModel(name: 'group6', id: 6),
      GroupModel(name: 'group7', id: 7),
      GroupModel(name: 'group8', id: 8),
    ];
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state.currState == CubitState.loading) {
          return LogoLoader();
        } else if (state.currState == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      child: Text(group.id.toString()),
                    ),
                    title: Text(group.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    trailing: SizedBox(
                      width: 80,
                      height: 40,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                    ' ${group.name} is now fil',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(.5)),
                            );
                          },
                          child: Text('Filter',
                              style: Theme.of(context).textTheme.bodySmall)),
                    )),
              );
            });
      },
    );
  }
}
