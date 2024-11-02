// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';
import 'package:telegram/feature/auth/verify_mail/domain/repo/verify_mail_base_repo.dart';

class VerifyOtpUseCase extends BaseUseCase <void, VerifyMailData> {
  VerifyMailRepository verifyMailBaseRepository;
  VerifyOtpUseCase(
    this.verifyMailBaseRepository,
  );

  @override
  Future<Either<Failure, void>> call(param) async {
    try {
      await verifyMailBaseRepository.verifyOtp(param);
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
