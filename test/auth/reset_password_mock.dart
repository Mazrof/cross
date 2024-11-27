import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/log_out_use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/reset_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_state.dart';

import 'reset_password_mock.mocks.dart';

Future<void> wait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

@GenerateMocks([ResetPasswordUseCase, NetworkManager, AppValidator, LogOutUseCase])
void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure WidgetsBinding is initialized

  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockNetworkManager mockNetworkManager;
  late MockAppValidator mockAppValidator;
  late ResetPasswordCubit resetPasswordCubit;
  late MockLogOutUseCase mockLogOutUseCase;

  setUp(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockNetworkManager = MockNetworkManager();
    mockLogOutUseCase = MockLogOutUseCase();
    mockAppValidator = MockAppValidator();
    resetPasswordCubit = ResetPasswordCubit(
      logOutUseCase: mockLogOutUseCase,
      resetPasswordUsecase: mockResetPasswordUseCase,
      networkManager: mockNetworkManager,
      appValidator: mockAppValidator,
    );
  });

  // tearDown(() {
  //   resetPasswordCubit.close();
  // });

  group('ResetPasswordCubit', () {
    test('initial state is correct', () {
      expect(resetPasswordCubit.state, ResetPasswordState());
    });

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, success] when password is reset successfully',
      build: () {
        when(mockResetPasswordUseCase.call(any, any))
            .thenAnswer((_) async => Right(unit));
        when (mockLogOutUseCase.call()).thenAnswer((_) async => Right(unit)); 
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        return resetPasswordCubit;
      },
      act: (cubit) async {
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';

        cubit.resetPassword();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        ResetPasswordState(state: CubitState.loading),
        ResetPasswordState(state: CubitState.success),
      ],
    
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, error] when password reset fails due to mismatch',
      build: () {
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        when (mockNetworkManager.isConnected()).thenAnswer((_) async => true);

        return resetPasswordCubit;
      },
      act: (cubit) async {
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23';

        cubit.resetPassword();
        await wait(500); 
      },
      expect: () => [
        ResetPasswordState(
            state: CubitState.failure,
            errorMessage: 'Password and confirm password does not match'),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, error] when password reset fails due to no internet connection',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        return resetPasswordCubit;
      },
      act: (cubit) async {
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';

        cubit.resetPassword();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        ResetPasswordState(state: CubitState.loading),
        ResetPasswordState(
            state: CubitState.failure, errorMessage: 'No Internet Connection'),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, error] when password reset fails due to server error',
      build: () {
        when(mockResetPasswordUseCase.call(any, any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Server error')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        return resetPasswordCubit;
      },
      act: (cubit) async {
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';

        cubit.resetPassword();
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        ResetPasswordState(state: CubitState.loading),
        ResetPasswordState(
            state: CubitState.failure, errorMessage: 'Server error'),
      ],
     
    );
  });
}
