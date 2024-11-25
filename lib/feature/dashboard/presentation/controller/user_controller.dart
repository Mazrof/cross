import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/save_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/ban_user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final NetworkManager networkManager;
  final GetUsersUseCase getUsersUseCase;
  final BanUserUseCase banUserUseCase;
  final GetUsersLocalUseCase getUsersLocalUseCase;
  final SaveUsersUseCase saveUsersUseCase;

  UsersCubit({
    required this.networkManager,
    required this.getUsersUseCase,
    required this.banUserUseCase,
    required this.getUsersLocalUseCase,
    required this.saveUsersUseCase,
  }) : super(UsersState(users: []));

  void fetchUsers() async {
    print('fetchUsers');
    emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(currState: CubitState.success, errorMessage: null));
        return;
      }

      final result = await getUsersUseCase.call();

      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
        },
        (users) {
          saveUsersUseCase.call(users);
          users = users.where((user) => user.status).toList();
          emit(state.copyWith(
              users: users, currState: CubitState.success, errorMessage: null));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }

  Future<bool> banUser(String userID) async {
    emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            currState: CubitState.failure,
            errorMessage: 'No Internet Connection'));
        return false;
      }

      final result = await banUserUseCase.call(userID);
      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
              return false;
        },
        (success) {
          final updatedUsers =
              state.users.where((user) => user.id != userID).toList();
          emit(state.copyWith(
              users: updatedUsers,
              currState: CubitState.success,
              errorMessage: null));
              return true;
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
          return false;
    }
    return false;
  }
}
