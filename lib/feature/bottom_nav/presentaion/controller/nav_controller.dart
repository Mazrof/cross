import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_state.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_controller.dart';
import 'package:telegram/feature/dashboard/presentation/screens/banned_users.dart';
import 'package:telegram/feature/dashboard/presentation/screens/groups_page.dart';
import 'package:telegram/feature/dashboard/presentation/screens/users_page.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavState(index: 0));
  final List<Widget> screens = [
    BlocProvider.value(
      value: sl<UsersCubit>()..fetchUsers(),
      child: UsersPage(),
    ),
    BlocProvider.value(
      value: sl<BannedUsersCubit>()..fetchBannedUsers(),
      child: BannedUsers(),
    ),
    BlocProvider.value(
      value: sl<GroupsCubit>()..fetchGroups(),
      child: GroupsPage(),
    ),
  ];
  void updateCurrentIndex(int index) {
    emit(state.copyWith(index: index));

    // Trigger fetch based on the index
    switch (index) {
      case 0:
        sl<UsersCubit>().fetchUsers();
        break;
      case 1:
        sl<BannedUsersCubit>().fetchBannedUsers();
        break;
      case 2:
        sl<GroupsCubit>().fetchGroups();
        break;
    }
  }
}
