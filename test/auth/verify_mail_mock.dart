import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/send_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/verify_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_cubit.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_state.dart';

import 'verify_mail_mock.mocks.dart';

Future<void> wait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

@GenerateMocks([SendOtpUseCase, VerifyOtpUseCase, NetworkManager])
void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure WidgetsBinding is initialized

  late MockSendOtpUseCase mockSendOtpUseCase;
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockNetworkManager mockNetworkManager;
  late VerifyMailCubit verifyMailCubit;

  setUp(() {
    mockSendOtpUseCase = MockSendOtpUseCase();
    mockNetworkManager = MockNetworkManager();
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    verifyMailCubit = VerifyMailCubit(
      mockNetworkManager,
      mockSendOtpUseCase,
      mockVerifyOtpUseCase,
    );
  });

  // tearDown(() {
  //   verifyMailCubit.close();
  // });

  group('VerifyMailCubit', () {
    test('initial state is correct', () {
      expect(verifyMailCubit.state, const VerifyMailState());
    });

    blocTest<VerifyMailCubit, VerifyMailState>(
      'emits [loading, success] when OTP is sent successfully',
      build: () {
        when(mockSendOtpUseCase.call(any, any))
            .thenAnswer((_) async => Right(unit));
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        return verifyMailCubit;
      },
      act: (cubit) async {
        cubit.sendVerificationMail('mail', 'test@example.com');
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        
        const VerifyMailState(status: VerifyMailStatus.loading),
        const VerifyMailState(status: VerifyMailStatus.optSent),
      ],
    );

    blocTest<VerifyMailCubit, VerifyMailState>(
      'emits [loading, error] when OTP sending fails',
      build: () {
        when(mockSendOtpUseCase.call(any, any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Failed to send OTP')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        return verifyMailCubit;
      },
      act: (cubit) async {
        cubit.sendVerificationMail('mail', 'test@example.com');
        await wait(500);
      },
      expect: () => [
        const VerifyMailState(status: VerifyMailStatus.loading),
        const VerifyMailState(
          status: VerifyMailStatus.error,
          errorMessage: 'Failed to send OTP',
        ),
      ],
    );

    blocTest<VerifyMailCubit, VerifyMailState>(
      'emits [loading, success] when OTP is verified successfully',
      build: () {
        when(mockVerifyOtpUseCase.call(any))
            .thenAnswer((_) async => Right(unit));
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        return verifyMailCubit;
      },
      act: (cubit) async {
        cubit.verifyOtp('mail', 'mariam@gmail.com', '123456');
        await wait(500); // Wait f,or 500 milliseconds
      },
      expect: () => [
        const VerifyMailState(status: VerifyMailStatus.loading),
        const VerifyMailState(status: VerifyMailStatus.success),
      ],
      verify: (_) {
        verify(mockVerifyOtpUseCase.call(any)).called(1);
      },
    );

    blocTest<VerifyMailCubit, VerifyMailState>(
      'emits [loading, error] when OTP verification fails',
      build: () {
        when(mockVerifyOtpUseCase.call(any)).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Invalid OTP')),
        );
        when(mockNetworkManager.isConnected()).thenAnswer((_) async => true);
        return verifyMailCubit;
      },
      act: (cubit) async {
        cubit.verifyOtp('mail', 'mariam@gmail.com', '123456');
        await wait(500); // Wait for 500 milliseconds
      },
      expect: () => [
        const VerifyMailState(status: VerifyMailStatus.loading),
        const VerifyMailState(
          status: VerifyMailStatus.error,
          errorMessage: 'Invalid OTP',
        ),
      ],
      verify: (_) {
        verify(mockVerifyOtpUseCase.call(any)).called(1);
      },
    );
  });
}
