import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/apply_filter.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(
      {required this.getGroupsUseCase,
      required this.networkManager,
      required this.applyFilterUseCase})
      : super(GroupsState(groups: []));

  GetGroupsUseCase getGroupsUseCase;
  NetworkManager networkManager;
  ApplyFilterUseCase applyFilterUseCase;
  void fetchGroups() async {
    emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            currState: CubitState.failure,
            errorMessage: 'No Internet Connection'));
        return; // Don't continue fetching if no connection
      }

      final result = await getGroupsUseCase.call();
      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
        },
        (groups) {
          groups.sort((a, b) => a.hasFilter ? 1 : -1);
          emit(state.copyWith(
              groups: groups,
              currState: CubitState.success,
              errorMessage: null));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }

  Future<bool> filterGroups(String id) async {
    // emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    print(state);
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            currState: CubitState.failure,
            errorMessage: 'No internet connection'));
        return false;
      }

      final result = await applyFilterUseCase.call(id);

      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
          return false;
        },
        (success) {
          fetchGroups();
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
