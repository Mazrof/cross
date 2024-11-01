import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/forget_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_state.dart';
import 'package:telegram/core/network/network_manager.dart';

import 'forget_password_mock.mocks.dart';


Future<void> wait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

@GenerateMocks([ForgetPasswordUseCase, NetworkManager,AppValidator])
void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure WidgetsBinding is initialized

  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockNetworkManager mockNetworkManager;
  late MockAppValidator mockAppValidator;
  late ForgetPasswordCubit forgetPasswordCubit;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockNetworkManager = MockNetworkManager();
    mockAppValidator = MockAppValidator();
    forgetPasswordCubit =
        ForgetPasswordCubit(forgetPasswordUseCase: mockForgetPasswordUseCase,
        networkManager: mockNetworkManager,
        appValidator: mockAppValidator
        );
  });

  // tearDown(() {
  //   forgetPasswordCubit.close();
  // });

  group('ForgetPasswordCubit', () {
    test('initial state is correct', () {
      expect(forgetPasswordCubit.state, const ForgetPasswordState());
    });

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when reset link is sent successfully',
      build: () {
        when(mockForgetPasswordUseCase.call(any))
            .thenAnswer((_) async => Right(unit));
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        return forgetPasswordCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@example.com';

        cubit.sendResetLink();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const ForgetPasswordState(
            status: CubitState.loading, email: 'test@example.com'),
        const ForgetPasswordState(
            status: CubitState.success, email: 'test@example.com'),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when reset link fails due to invalid email',
      build: () {
        when(mockForgetPasswordUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid email')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        return forgetPasswordCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'invalid@example.com';
        

        cubit.sendResetLink();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const ForgetPasswordState(
            status: CubitState.loading, email: 'invalid@example.com'),
        const ForgetPasswordState(
          status: CubitState.failure,
          email: 'invalid@example.com',
          errorMessage: 'Invalid email',
        ),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when reset link fails due to no internet connection',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);

        return forgetPasswordCubit;
      },
      act: (cubit) async {
        cubit.emailController.text = 'test@example.com';


        cubit.sendResetLink();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const ForgetPasswordState(
            status: CubitState.loading, email: 'test@example.com'),
        const ForgetPasswordState(
          status: CubitState.failure,
          email: 'test@example.com',
          errorMessage: 'No Internet Connection',
        ),
      ],
    );
  });
}
