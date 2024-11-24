import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_state.dart';

class BannedUsers extends StatelessWidget {
  const BannedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
      User(id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'),
      User(id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com'),
      User(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
      User(id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'),
      User(id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com'),
      User(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
      User(id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'),
      User(id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com'),
      User(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
      User(id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'),
      User(id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com'),
      // Add more users as needed
    ];

    return BlocBuilder<BannedUsersCubit, BannedUsersState>(
      builder: (context, state) {
        if (state.currState == CubitState.loading) {
          return LogoLoader();
        } else if (state.currState == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }

        return Scaffold(
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    child: Text(user.id.toString()),
                  ),
                  title: Text(
                    user.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    user.email,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add, color: Colors.red),
                    onPressed: () {
                      // Handle ban user action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('User ${user.name} UnBanned',style: Theme.of(context).textTheme.bodySmall,),
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(.5)),
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
