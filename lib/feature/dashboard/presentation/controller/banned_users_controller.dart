import 'package:bloc/bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/groups.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_state.dart';

class BannedUsersCubit extends Cubit<BannedUsersState> {
  BannedUsersCubit() : super(BannedUsersState(bannedUsers: []));

  void fetchGroups() async {
    emit(state.copyWith(currState: CubitState.loading));
    try {
      // Simulate fetching users from the backend
      await Future.delayed(Duration(seconds: 2));

      final users = [
        User(id: 1, name: 'John Doe', email: ''),
        User(id: 2, name: 'Jane Smith', email: ''),
      ];

      emit(state.copyWith(bannedUsers: users, currState: CubitState.success));
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }

  void UnBanUSer(String filter) {
    
    final updatedUsers = List<User>.from(state.bannedUsers)
      ..removeWhere((element) => element.name.contains(filter));

      /// Simulate banning user
    emit(state.copyWith(
        bannedUsers: updatedUsers, currState: CubitState.success));
        

  }
}

