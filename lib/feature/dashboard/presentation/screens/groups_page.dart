import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/groups.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = [
      Group(name: 'group1', id: '1'),
      Group(name: 'group2', id: '2'),
      Group(name: 'group3', id: '3'),
      Group(name: 'group4', id: '4'),
      Group(name: 'group5', id: '5'),
      Group(name: 'group6', id: '6'),
      Group(name: 'group7', id: '7'),
      Group(name: 'group8', id: '8'),
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
                          onPressed: () {},
                          child: Text('Filter',
                              style: Theme.of(context).textTheme.bodySmall)),
                    )),
              );
            });
      },
    );
  }
}
