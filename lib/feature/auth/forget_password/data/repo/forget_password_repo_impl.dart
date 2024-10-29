import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/forget_password/data/remote_data/remote_data.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

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

  // @override
  // Future<Either<Failure, void>> logoutFromAllDevices() {

  // }

}
