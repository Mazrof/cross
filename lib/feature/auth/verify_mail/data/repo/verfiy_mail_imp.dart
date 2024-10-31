import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/verify_mail/data/data_source/verify_mail_remot_data_source.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';
import 'package:telegram/feature/auth/verify_mail/domain/repo/verify_mail_base_repo.dart';

class VerfiyMailRepositoryImp extends VerifyMailRepository {
  VerifyMailDataSource verifyMailRemoteDataSource;
  VerfiyMailRepositoryImp({
    required this.verifyMailRemoteDataSource,
  });
  @override
  Future<Either<Failure, void>> sendOtp(String method,String email) {
    return verifyMailRemoteDataSource.sendOtp(method,email);
  }

  @override
  Future<Either<Failure, void>> verifyOtp(VerifyMailData data) {
    return verifyMailRemoteDataSource.verifyOtp(data);
  }
}
