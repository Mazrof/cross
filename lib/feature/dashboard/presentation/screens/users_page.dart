import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
      if (state.currState == CubitState.loading) {
        return LogoLoader();
      } else if (state.currState == CubitState.failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
        });
      }

      return Scaffold(
        body: ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user.username[0].toUpperCase()),
                ),
                title: Text(
                  user.username,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ${user.email} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Bio: ${user.bio}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Phone: ${user.phone}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        Icon(
                          user.activeNow ? Icons.circle : Icons.circle_outlined,
                          color: user.activeNow
                              ? Colors.green
                              : AppColors.errorColor,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(user.activeNow ? 'Active Now' : 'Inactive'),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add, color: AppColors.errorColor),
                  onPressed: () {
                    context.read<UsersCubit>().banUser(user.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User ${user.username} banned')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
