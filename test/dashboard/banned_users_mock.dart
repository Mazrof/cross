import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/unban_user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_state.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_controller.dart';

import 'banned_users_mock.mocks.dart';

@GenerateMocks([
  NetworkManager,
  GetUsersUseCase,
  UnBanUserUseCase,
  GetUsersLocalUseCase,
])
void main() {
  late MockNetworkManager mockNetworkManager;
  late MockGetUsersUseCase mockGetUsersUseCase;
  late MockUnBanUserUseCase mockUnBanUserUseCase;
  late MockGetUsersLocalUseCase mockGetUsersLocalUseCase;
  late BannedUsersCubit bannedUsersCubit;

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    mockGetUsersUseCase = MockGetUsersUseCase();
    mockUnBanUserUseCase = MockUnBanUserUseCase();
    mockGetUsersLocalUseCase = MockGetUsersLocalUseCase();
    bannedUsersCubit = BannedUsersCubit(
      getUsersLocalUseCase: mockGetUsersLocalUseCase,
      getUsersUseCase: mockGetUsersUseCase,
      unBanUserUseCase: mockUnBanUserUseCase,
      networkManager: mockNetworkManager,
    );
  });

  group('BannedUsersCubit', () {
    final users = [
      UserModel(
        id: '1',
        username: 'John Doe',
        status: false,
        email: 'john.doe@example.com',
        bio: 'Bio of John Doe',
        activeNow: false,
        phone: '1234567890',
      ),
      UserModel(
        id: '2',
        username: 'Jane Smith',
        status: true,
        email: 'jane.smith@example.com',
        bio: 'Bio of Jane Smith',
        activeNow: false,
        phone: '0987654321',
      ),
    ];

    blocTest<BannedUsersCubit, BannedUsersState>(
      'emits [loading, success] when fetchBannedUsers is called and network is connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockGetUsersUseCase.call()).thenAnswer((_) async => Right(users));
        return bannedUsersCubit;
      },
      act: (cubit) => cubit.fetchBannedUsers(),
      expect: () => [
        BannedUsersState(bannedUsers: [], currState: CubitState.loading),
        BannedUsersState(
            bannedUsers: [users[0]], currState: CubitState.success),
      ],
    );

    blocTest<BannedUsersCubit, BannedUsersState>(
      'emits [loading, success] when fetchBannedUsers is called and network is not connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockGetUsersLocalUseCase.call()).thenAnswer((_) async => users);
        return bannedUsersCubit;
      },
      act: (cubit) => cubit.fetchBannedUsers(),
      expect: () => [
        BannedUsersState(bannedUsers: [], currState: CubitState.loading),
        BannedUsersState(
            bannedUsers: [users[0]], currState: CubitState.success),
      ],
    );

    blocTest<BannedUsersCubit, BannedUsersState>(
      'emits [loading, success] when unbanUser is called and network is connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockUnBanUserUseCase.call(any))
            .thenAnswer((_) async => Right(true));
        bannedUsersCubit.emit(BannedUsersState(
            bannedUsers: [users[0]], currState: CubitState.success));
        return bannedUsersCubit;
      },
      act: (cubit) => cubit.unbanUser('1'),
      expect: () => [
        bannedUsersCubit.state
            .copyWith(bannedUsers: [users[0]], currState: CubitState.loading),
        bannedUsersCubit.state
            .copyWith(bannedUsers: [], currState: CubitState.success),
      ],
    );

    blocTest<BannedUsersCubit, BannedUsersState>(
      'emits [loading, failure] when unbanUser is called and network is not connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        bannedUsersCubit.emit(BannedUsersState(
            bannedUsers: [users[0]], currState: CubitState.success));
        return bannedUsersCubit;
      },
      act: (cubit) => cubit.unbanUser('1'),
      expect: () => [
        BannedUsersState(
            bannedUsers: [users[0]], currState: CubitState.loading),
        BannedUsersState(
            bannedUsers: [users[0]],
            currState: CubitState.failure,
            errorMessage: 'No Internet Connection'),
      ],
    );
  });
}
