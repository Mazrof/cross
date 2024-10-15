import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';

abstract class RemoteBaseAuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  // Future<Either<Failure, bool>> signUp(UserModel userModel);
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> verifyMail();
  Future<Either<Failure, bool>> autoRedirect();
  Future<Either<Failure, void>> signOut();
}
