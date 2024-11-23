import 'package:bloc/bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/groups.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(GroupsState(groups: []));

  void fetchGroups() async {
    emit(state.copyWith(currState: CubitState.loading));
    try {
      // Simulate fetching groups from the backend
      await Future.delayed(Duration(seconds: 2));
      final groups = [
        Group(id: '1', name: 'Group 1'),
        Group(id: '2', name: 'Group 2'),
        Group(id: '3', name: 'Group 3'),
      ];
      emit(state.copyWith(groups: groups, currState: CubitState.success));
    } catch (e) {
      emit(state.copyWith( currState: CubitState.failure , errorMessage: e.toString()));
    }
  }

  void filterGroups(String filter) {
    final filteredGroups = List<Group>.from(state.groups)
      ..removeWhere((element) => !element.name.contains(filter));
    emit(state.copyWith(groups: filteredGroups));
  }
}
