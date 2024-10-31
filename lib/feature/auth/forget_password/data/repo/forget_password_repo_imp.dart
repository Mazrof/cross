import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/forget_password/data/data_source/forget_password_data_source.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  ForgetPasswordDataSource forgetPasswordRemoteDataSource;

  ForgetPasswordRepositoryImpl({required this.forgetPasswordRemoteDataSource});

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    return forgetPasswordRemoteDataSource.forgetPassword(email);
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      String token, String newPassword) async {
    return forgetPasswordRemoteDataSource.resetPassword(token, newPassword);
  }

    @override
  Future<Either<Failure, void>> logoutFromAllDevices() async {
    return forgetPasswordRemoteDataSource.logoutFromAllDevices();
  }

}
