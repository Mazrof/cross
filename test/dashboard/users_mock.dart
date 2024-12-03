import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/ban_user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_state.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_controller.dart';

import 'users_mock.mocks.dart';

@GenerateMocks([
  NetworkManager,
  GetUsersUseCase,
  BanUserUseCase,
])
void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure WidgetsBinding is initialized
  late MockNetworkManager mockNetworkManager;
  late MockGetUsersUseCase mockGetUsersUseCase;
  late MockBanUserUseCase mockBanUserUseCase;

  late UsersCubit usersCubit;

  Future<void> wait(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    mockGetUsersUseCase = MockGetUsersUseCase();
    mockBanUserUseCase = MockBanUserUseCase();

    usersCubit = UsersCubit(
      networkManager: mockNetworkManager,
      getUsersUseCase: mockGetUsersUseCase,
      banUserUseCase: mockBanUserUseCase,
    );
  });

  group('UsersCubit', () {
    final users = [
      UserModel(
        id: '1',
        username: 'John Doe',
        status: true,
        email: 'john.doe@example.com',
        bio: 'Bio of John Doe',
        activeNow: true,
        phone: '1234567890',
      ),
      UserModel(
        id: '2',
        username: 'Jane Smith',
        status: false,
        email: 'jane.smith@example.com',
        bio: 'Bio of Jane Smith',
        activeNow: false,
        phone: '0987654321',
      ),
    ];
    blocTest<UsersCubit, UsersState>(
      'emits [loading, success] when fetchUsers is called and network is connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockGetUsersUseCase.call()).thenAnswer((_) async => Right(users));
        return usersCubit;
      },
      act: (cubit) async {
        cubit.fetchUsers();
      },
      expect: () => [
        UsersState(users: [], currState: CubitState.loading),
        UsersState(users: [users[0]], currState: CubitState.success),
      ],
    );

    blocTest<UsersCubit, UsersState>(
      'emits [loading, success] when fetchUsers is called and network is not connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);

        usersCubit
            .emit(UsersState(users: [users[0]], currState: CubitState.success));
        return usersCubit;
      },
      act: (cubit) async {
        cubit.fetchUsers();
        await wait(500);
      },
      expect: () => [
        UsersState(users: [users[0]], currState: CubitState.loading),
        UsersState(users: [users[0]], currState: CubitState.success),
      ],
    );

    blocTest<UsersCubit, UsersState>(
      'emits [loading, success] when banUser is called and network is connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockBanUserUseCase.call(any)).thenAnswer((_) async => Right(true));
        usersCubit
            .emit(UsersState(users: [users[0]], currState: CubitState.success));
        return usersCubit;
      },
      act: (cubit) async {
        cubit.banUser('1');
        await wait(500);
      },
      expect: () => [
        usersCubit.state
            .copyWith(users: [users[0]], currState: CubitState.loading),
        UsersState(users: [], currState: CubitState.success),
      ],
    );

    blocTest<UsersCubit, UsersState>(
      'emits [loading, failure] when banUser is called and network is not connected',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        usersCubit
            .emit(UsersState(users: [users[0]], currState: CubitState.success));
        return usersCubit;
      },
      act: (cubit) async {
        cubit.banUser('1');
        await wait(500);
      },
      expect: () => [
        UsersState(users: [users[0]], currState: CubitState.loading),
        UsersState(
            users: [users[0]],
            currState: CubitState.failure,
            errorMessage: 'No Internet Connection'),
      ],
    );
  });
}
