import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/unban_user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_state.dart';

class BannedUsersCubit extends Cubit<BannedUsersState> {
  final GetUsersLocalUseCase getUsersLocalUseCase;
  final GetUsersUseCase getUsersUseCase;
  final UnBanUserUseCase unBanUserUseCase;
  final NetworkManager networkManager;

  BannedUsersCubit({
    required this.getUsersLocalUseCase,
    required this.getUsersUseCase,
    required this.unBanUserUseCase,
    required this.networkManager,
  }) : super(BannedUsersState(bannedUsers: []));

  void fetchBannedUsers() async {
    emit(state.copyWith(currState: CubitState.loading));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
     
        emit(state.copyWith(
            currState: CubitState.success,));
        return;
      }

      final result = await getUsersUseCase.call();

      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
        },
        (users) {
          List<User> bannedUsers =
              users.where((user) => !user.status! ).toList();
          emit(state.copyWith(
              bannedUsers: bannedUsers, currState: CubitState.success));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }

  Future<bool> unbanUser(String userID) async {
    emit(state.copyWith(currState: CubitState.loading));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            currState: CubitState.failure,
            errorMessage: 'No Internet Connection'));
        return false;
      }

      final result = await unBanUserUseCase.call(userID);
      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
               return false;
        },
        (success) {
          final updatedBannedUsers =
              state.bannedUsers.where((user) => user.id != userID).toList();
          emit(state.copyWith(
              bannedUsers: updatedBannedUsers, currState: CubitState.success));
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
