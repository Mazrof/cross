import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/save_groups.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/apply_filter.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';


class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(
      {required this.getGroupsUseCase,
      required this.networkManager,
      required this.saveGroupsUseCase,
      required this.getGroupLocalUseCase,
      required this.applyFilterUseCase}
  ) : super(GroupsState(groups: []));

  GetGroupsUseCase getGroupsUseCase;
  NetworkManager networkManager ;
  SaveGroupsUseCase saveGroupsUseCase;
  GetGroupLocalUseCase getGroupLocalUseCase;
  ApplyFilterUseCase applyFilterUseCase;






void fetchGroups() async {
    emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        final result = await getGroupLocalUseCase.call();
        emit(state.copyWith(currState: CubitState.success, groups: result, errorMessage: null));
        return;
      }

      final result = await getGroupsUseCase.call();

      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
        },
        (groups) {
          saveGroupsUseCase.call(groups);
          emit(state.copyWith(groups: groups, currState: CubitState.success, errorMessage: null));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }


  void filterGroups(String filter) async {
    emit(state.copyWith(currState: CubitState.loading, errorMessage: null));
    try {
      
      bool connection =await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            currState: CubitState.failure, errorMessage: 'No internet connection'));
        return;
      }

      final result = await applyFilterUseCase.call(filter);

      result.fold(
        (failure) {
          emit(state.copyWith(
              currState: CubitState.failure, errorMessage: failure.message));
        },
        (success) {
          emit(state.copyWith( currState: CubitState.success, errorMessage: null));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          currState: CubitState.failure, errorMessage: e.toString()));
    }
  }
}
