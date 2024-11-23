import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/feature/dashboard/presentation/screens/banned_users.dart';
import 'package:telegram/feature/dashboard/presentation/screens/groubs_page.dart';
import 'package:telegram/feature/dashboard/presentation/screens/users_page.dart';

class NavCubit extends Cubit<int> {
  NavCubit() : super(0);
  int index=0;

  final List<Widget> screens = [
    UsersPage(),
    GroubsPage(),
    BannedUsers(),
  ];

  void updateCurrentIndex(int index) {
    index=index;
    emit(index);

  }
}