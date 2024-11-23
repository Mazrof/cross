import 'package:bloc/bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState(users: []));

  void fetchUsers() async {
    emit(state.copyWith(currState: CubitState.loading));
    try {
      // Simulate fetching users from the backend
      await Future.delayed(Duration(seconds: 2));
      final users = [
        User(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
        User(id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'),
        User(id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com'),
      ];

      emit(state.copyWith(users: users, currState: CubitState.success));
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }

  void banUser(User user) {
    final updatedUsers = List<User>.from(state.users)..remove(user);
    // Simulate banning user
    emit(state.copyWith(
        users: updatedUsers,
        currState: CubitState.success));
  }
}
