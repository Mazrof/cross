import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_use_case.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_state.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:dartz/dartz.dart';

import 'login_mock.mocks.dart';

@GenerateMocks([LoginUseCase, NetworkManager, AppValidator])
void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure WidgetsBinding is initialized

  late MockLoginUseCase mockLoginUseCase;
  late MockNetworkManager mockNetworkManager;
  late MockAppValidator mockAppValidator;

  late LoginCubit loginCubit;
  Future<void> wait(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  setUp(() {
    mockAppValidator = MockAppValidator();
    mockLoginUseCase = MockLoginUseCase();
    mockNetworkManager = MockNetworkManager();

    loginCubit = LoginCubit(
        appValidator: mockAppValidator,
        loginUseCase: mockLoginUseCase,
        networkManager: mockNetworkManager);
  });

  group('LoginCubit', () {
    test('initial state is correct', () {
      expect(loginCubit.state, const LoginState());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login is successful',
      build: () {
        when(mockLoginUseCase.call(any)).thenAnswer((_) async => Right(unit));
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);

        return loginCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@example.com';
        cubit.passwordController.text = 'passwordPa23@@';

        cubit.login();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const LoginState(state: LoginStatusEnum.loading),
        const LoginState(state: LoginStatusEnum.success),
      ],
    
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] when login fails',
      build: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid credentials')),
        );

        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);

        return loginCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = '';
        cubit.passwordController.text = '';

        cubit.login();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const LoginState(state: LoginStatusEnum.loading),
        const LoginState(
          state: LoginStatusEnum.error,
          error: 'Invalid credentials',
          remainingAttempts: 2,
        ),
      ],
      verify: (_) {
        verify(mockLoginUseCase.call(any)).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, suspended] when login fails three times',
      build: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid credentials')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);

        return loginCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'wrongpasswordDF!dd2Ds';
        cubit.login();
        await wait(500); // Wait for 500 milliseconds
        cubit.login();
        await wait(500); // Wait for 500 milliseconds
        cubit.login();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const LoginState(state: LoginStatusEnum.loading),
        const LoginState(
          state: LoginStatusEnum.error,
          error: 'Invalid credentials',
          remainingAttempts: 2,
        ),
        const LoginState(
          state: LoginStatusEnum.loading,
          error: 'Invalid credentials',
          remainingAttempts: 2,
        ),
        const LoginState(
          state: LoginStatusEnum.error,
          error: 'Invalid credentials',
          remainingAttempts: 1,
        ),
        const LoginState(
          state: LoginStatusEnum.loading,
          error: 'Invalid credentials',
          remainingAttempts: 1,
        ),
        const LoginState(
          state: LoginStatusEnum.suspended,
          error: 'Invalid credentials',
          remainingAttempts: 0,
        ),
      ],
    );


    blocTest<LoginCubit, LoginState>(
      'emits [loading, suspended] when login fails three times',
      build: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid credentials')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);

        return loginCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'wrongpasswordDF!dd2Ds';
        cubit.login();
  
      },
      expect: () => [
        const LoginState(state: LoginStatusEnum.loading),
        const LoginState(
          state: LoginStatusEnum.error,
          error: 'No Internet Connection',
          remainingAttempts: 3,
        ),
      
      ],
    );

    
    blocTest<LoginCubit, LoginState>(
      'emits [loading, suspended] when login fails three times',
      build: () {
        when(mockLoginUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid credentials')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockAppValidator.isFormValid(any)).thenReturn(false);

        return loginCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@gmail.com';
        cubit.passwordController.text = 'wrongpasswordDF!dd2Ds';
        cubit.login();
      },
      expect: () => [
        const LoginState(
          state: LoginStatusEnum.error,
          error: 'Please enter your email and password',
          remainingAttempts: 3,
        ),
      ],
    );

  });
}
