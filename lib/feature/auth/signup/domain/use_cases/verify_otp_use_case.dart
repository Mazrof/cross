// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';


class VerifyOtpUseCase
    extends BaseUseCase<Map<String, dynamic>, (String, String)> {
  SignUpRepo signUpRepo;
  VerifyOtpUseCase(
    this.signUpRepo,
  );

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      (String email, String otpCode) parameter) async {
    return await signUpRepo.verifyOtp(parameter.$1, parameter.$2);
  }
}
