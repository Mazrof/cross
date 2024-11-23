import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_state.dart';
import 'package:telegram/feature/dashboard/presentation/screens/banned_users.dart';
import 'package:telegram/feature/dashboard/presentation/screens/groubs_page.dart';
import 'package:telegram/feature/dashboard/presentation/screens/users_page.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavState(index: 0));

  final List<Widget> screens = [
    UsersPage(),
    BannedUsers(),
    GroubsPage(),
  ];

  void updateCurrentIndex(int index) {
    emit(NavState(index: index));
  }
}
