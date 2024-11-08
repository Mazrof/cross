import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/check_recaptcha_tocken.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/not_robot.dart'; // Assuming this file contains the RecaptchaService

import 'signup_mock.mocks.dart';

Future<void> wait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

@GenerateMocks([
  RegisterUseCase,
  SaveRegisterInfoUseCase,
  NetworkManager,
  AppValidator,
  RecaptchaService,
  CheckRecaptchaTocken
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRegisterUseCase mockRegisterUseCase;
  late MockSaveRegisterInfoUseCase mockSaveRegisterInfoUseCase;
  late MockNetworkManager mockNetworkManager;
  late MockAppValidator mockAppValidator;
  late MockRecaptchaService mockRecaptchaService;
  late SignUpCubit signUpCubit;
  late MockCheckRecaptchaTocken checkRecaptchaTocken;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockSaveRegisterInfoUseCase = MockSaveRegisterInfoUseCase();
    mockNetworkManager = MockNetworkManager();
    mockAppValidator = MockAppValidator();
    mockRecaptchaService = MockRecaptchaService();
    checkRecaptchaTocken = MockCheckRecaptchaTocken();
    signUpCubit = SignUpCubit(
      appValidator: mockAppValidator,
      networkManager: mockNetworkManager,
      registerUseCase: mockRegisterUseCase,
      saveRegisterInfoUseCase: mockSaveRegisterInfoUseCase,
      recaptchaService: mockRecaptchaService,
      checkRecaptchaTocken: checkRecaptchaTocken,
    );
  });

  group('SignUpCubit', () {
    test('initial state is correct', () {
      expect(signUpCubit.state, SignupState());
    });

    blocTest<SignUpCubit, SignupState>(
      'emits [loading, success] when sign up is successful',
      build: () {
        when(mockRegisterUseCase.call(any))
            .thenAnswer((_) async => Right('Success'));
        when(mockSaveRegisterInfoUseCase.call(any))
            .thenAnswer((_) async => Right('Success'));
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        when(mockRecaptchaService.handleRecaptcha())
            .thenAnswer((_) async => 'recaptcha-token');

        when(checkRecaptchaTocken.call(any))
            .thenAnswer((_) async => Right(true));

        return signUpCubit;
      },
      act: (cubit) async {
        cubit.firstNameController.text = 'John';
        cubit.lastNameController.text = 'Doe';
        cubit.emailController.text = 'john.doe@example.com';
        cubit.phoneController.text = '1234567890';
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';
        cubit.state.isPrivacyPolicyAccepted = true;

        cubit.signUp();
        await wait(500);
      },
      expect: () => [
        SignupState(
          state: CubitState.loading,
          isPrivacyPolicyAccepted: true,
        ),
        SignupState(state: CubitState.success, isPrivacyPolicyAccepted: true),
      ],
    );

    blocTest<SignUpCubit, SignupState>(
      'emits [loading, error] when sign up fails due to invalid data',
      build: () {
        when(mockRegisterUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid data')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        when(mockRecaptchaService.handleRecaptcha())
            .thenAnswer((_) async => 'recaptcha-token');
        when(checkRecaptchaTocken.call(any))
            .thenAnswer((_) async => Right(true));
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.firstNameController.text = 'John';
        cubit.lastNameController.text = 'Doe';
        cubit.emailController.text = 'john.doe@example.com';
        cubit.phoneController.text = '1234567890';
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';
        cubit.state.isPrivacyPolicyAccepted = true;

        cubit.signUp();
        await wait(500);
      },
      expect: () => [
        SignupState(
          state: CubitState.loading,
          isPrivacyPolicyAccepted: true,
        ),
        SignupState(
          state: CubitState.failure,
          errorMessage: 'Invalid data',
          isPrivacyPolicyAccepted: true,
        ),
      ],
    );

    blocTest<SignUpCubit, SignupState>(
      'emits [loading, error] when sign up fails due to no internet connection',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => false);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        when(mockRecaptchaService.handleRecaptcha())
            .thenAnswer((_) async => 'recaptcha-token');
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.firstNameController.text = 'John';
        cubit.lastNameController.text = 'Doe';
        cubit.emailController.text = 'john.doe@example.com';
        cubit.phoneController.text = '1234567890';
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';
        cubit.state.isPrivacyPolicyAccepted = true;

        cubit.signUp();
        await wait(500);
      },
      expect: () => [
        SignupState(
          state: CubitState.loading,
          isPrivacyPolicyAccepted: true,
        ),
        SignupState(
          state: CubitState.failure,
          errorMessage: 'No Internet Connection',
          isPrivacyPolicyAccepted: true,
        ),
      ],
    );

    blocTest<SignUpCubit, SignupState>(
      'emits [loading, error] when reCAPTCHA fails1',
      build: () {
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        when(mockAppValidator.isFormValid(any)).thenReturn(true);
        when(mockRecaptchaService.handleRecaptcha())
            .thenAnswer((_) async => null); // Simulate reCAPTCHA failure
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.firstNameController.text = 'John';
        cubit.lastNameController.text = 'Doe';
        cubit.emailController.text = 'john.doe@example.com';
        cubit.phoneController.text = '1234567890';
        cubit.passwordController.text = 'passwordPa23@@';
        cubit.confirmPasswordController.text = 'passwordPa23@@';
        cubit.state.isPrivacyPolicyAccepted = true;

        cubit.signUp();
        await wait(500);
      },
      expect: () => [
        SignupState(
          state: CubitState.loading,
          isPrivacyPolicyAccepted: true,
        ),
        SignupState(
          state: CubitState.failure,
          errorMessage: 'reCAPTCHA verification failed.',
          isPrivacyPolicyAccepted: true,
        ),
      ],
    );
  });

  blocTest<SignUpCubit, SignupState>(
    'emits [loading, error] when reCAPTCHA fails2',
    build: () {
      when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
      when(mockAppValidator.isFormValid(any)).thenReturn(true);
      when(mockRecaptchaService.handleRecaptcha())
          .thenAnswer((_) async => 'recaptcha');
      when(checkRecaptchaTocken.call(any)).thenAnswer(
        (_) async =>
            Left(ServerFailure(message: 'reCAPTCHA verification failed.')),
      );

      return signUpCubit;
    },
    act: (cubit) async {
      cubit.firstNameController.text = 'John';
      cubit.lastNameController.text = 'Doe';
      cubit.emailController.text = 'john.doe@example.com';
      cubit.phoneController.text = '1234567890';
      cubit.passwordController.text = 'passwordPa23@@';
      cubit.confirmPasswordController.text = 'passwordPa23@@';
      cubit.state.isPrivacyPolicyAccepted = true;

      cubit.signUp();
      await wait(500);
    },
    expect: () => [
      SignupState(
        state: CubitState.loading,
        isPrivacyPolicyAccepted: true,
      ),
      SignupState(
        state: CubitState.failure,
        errorMessage: 'reCAPTCHA verification failed.',
        isPrivacyPolicyAccepted: true,
      ),
    ],
  );
}
