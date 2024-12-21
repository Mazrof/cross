import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
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
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: UsersContent(state: state));
      } else if (state.currState == CubitState.failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
        });
      }

      return Scaffold(
          body: UsersContent(
        state: state,
      ));
    });
  }
}

class UsersContent extends StatelessWidget {
  const UsersContent({
    required this.state,
    super.key,
  });
  final state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        final user = state.users[index];
        return Card(
          surfaceTintColor: AppColors.primaryColor,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              child: Text(user.id.toString()),
            ),
            title: Text(
              user.username ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.email != null)
                  Text('Email: ${user.email} ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grey)),
                if (user.bio != null)
                  Text('Bio: ${user.bio}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grey)),
                if (user.phone != null)
                  Text('Phone: ${user.phone}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grey)),
                Row(
                  children: [
                    Icon(
                      user.activeNow == true
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: user.activeNow == true
                          ? Colors.green
                          : AppColors.errorColor,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(user.activeNow == true ? 'Active Now' : 'Inactive',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.grey.withOpacity(0.7))),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.block,
                color: AppColors.errorColor,
                size: 35,
              ),
              onPressed: () async {
                 sl<UsersCubit>().banUser(user.id);
                
              },
            ),
          ),
        );
      },
    );
  }
}
