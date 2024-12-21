import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> resetPassword(
      String token, String newPassword, int id);
  Future<Either<Failure, void>> logoutFromAllDevices();
}
