import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/save_groups.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/apply_filter.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_state.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';

import 'groups_mock.mocks.dart';

@GenerateMocks([
  NetworkManager,
  GetGroupsUseCase,
  GetGroupLocalUseCase,
  SaveGroupsUseCase,
  ApplyFilterUseCase,
])
void main() {
  late MockNetworkManager mockNetworkManager;
  late MockGetGroupsUseCase mockGetGroupsUseCase;
  late MockGetGroupLocalUseCase mockGetGroupsLocalUseCase;
  late MockSaveGroupsUseCase mockSaveGroupsUseCase;
  late MockApplyFilterUseCase mockApplyFilterUseCase;
  late GroupsCubit groupsCubit;

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    mockGetGroupsUseCase = MockGetGroupsUseCase();
    mockGetGroupsLocalUseCase = MockGetGroupLocalUseCase();
    mockApplyFilterUseCase = MockApplyFilterUseCase();
    mockSaveGroupsUseCase = MockSaveGroupsUseCase();
    groupsCubit = GroupsCubit(
      networkManager: mockNetworkManager,
      getGroupsUseCase: mockGetGroupsUseCase,
      saveGroupsUseCase: mockSaveGroupsUseCase,
      getGroupLocalUseCase: mockGetGroupsLocalUseCase,
      applyFilterUseCase: mockApplyFilterUseCase,
    );
  });

  group('GroupsCubit', () {
    final groups = [
      GroupModel(
          id: '1',
          groupSize: 10,
          name: 'Group 1',
          privacy: true,
          hasFilter: true),
      GroupModel(
          id: '2',
          groupSize: 20,
          name: 'Group 2',
          privacy: false,
          hasFilter: true),
    ];

    blocTest<GroupsCubit, GroupsState>(
      'emits [loading, success] when fetchGroups is called and network is connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockGetGroupsUseCase.call())
            .thenAnswer((_) async => Right(groups));
        return groupsCubit;
      },
      act: (cubit) => cubit.fetchGroups(),
      expect: () => [
        GroupsState(groups: [], currState: CubitState.loading),
        GroupsState(groups: groups, currState: CubitState.success),
      ],
    );

    blocTest<GroupsCubit, GroupsState>(
      'emits [loading, success] when fetchGroups is called and network is not connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockGetGroupsLocalUseCase.call()).thenAnswer((_) async => groups);
        return groupsCubit;
      },
      act: (cubit) => cubit.fetchGroups(),
      expect: () => [
        GroupsState(groups: [], currState: CubitState.loading),
        GroupsState(groups: groups, currState: CubitState.success),
      ],
    );

    blocTest<GroupsCubit, GroupsState>(
      'emits [loading, failure] when fetchGroups is called and network is connected but fails',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockGetGroupsUseCase.call()).thenAnswer((_) async =>
            Left(ServerFailure(message: 'Failed to fetch groups')));
        return groupsCubit;
      },
      act: (cubit) => cubit.fetchGroups(),
      expect: () => [
        GroupsState(groups: [], currState: CubitState.loading),
        GroupsState(
            groups: [],
            currState: CubitState.failure,
            errorMessage: 'Failed to fetch groups'),
      ],
    );

    blocTest<GroupsCubit, GroupsState>(
      'emits [loading, success] when filterGroups is called no internet connection',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockApplyFilterUseCase.call(any))
            .thenAnswer((_) async => Right(true));

        return groupsCubit;
      },
      act: (cubit) {
        cubit.filterGroups('1',);
      },
      expect: () => [
        GroupsState(groups: [], currState: CubitState.loading),
        GroupsState(
            groups: [],
            currState: CubitState.failure,
            errorMessage: 'No internet connection'),
      ],
    );

    blocTest<GroupsCubit, GroupsState>(
      'emits [loading, success] when filterGroups is called ',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockApplyFilterUseCase.call('1'))
            .thenAnswer((_) async => Right(true));
        groupsCubit
            .emit(GroupsState(groups: groups, currState: CubitState.success));
        return groupsCubit;
      },
      act: (cubit) {
        cubit.filterGroups('1');
      },
      expect: () => [
        groupsCubit.state.copyWith(
            groups: groups, currState: CubitState.loading, errorMessage: null),
        groupsCubit.state.copyWith(
            groups: groups, currState: CubitState.success, errorMessage: null),
      ],
    );
  });
}
