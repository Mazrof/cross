// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/repo/verify_mail_base_repo.dart';

class SendOtpUseCase extends TwoParameters<void,String, String> {
  VerifyMailRepository verifyMailBaseRepository;
  SendOtpUseCase(
    this.verifyMailBaseRepository,
  );

  @override
  Future<Either<Failure, void>> call(String parameter1,String parameter2) async {
    return await verifyMailBaseRepository.sendOtp(parameter1, parameter2);
  }
}
