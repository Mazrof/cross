import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';

abstract class VerifyMailRepository {
  Future<Either<Failure, void>> sendOtp(String method,String email);
  Future<Either<Failure, bool>> verifyOtp(VerifyMailData data);
}
