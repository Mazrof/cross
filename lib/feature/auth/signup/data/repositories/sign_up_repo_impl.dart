import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/signup/data/data_source/local_data/sign_up_local_data_source.dart';
import 'package:telegram/feature/auth/signup/data/data_source/remote_data/sign_up_remote_data_source.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';

class SignUpRepoImpl extends SignUpRepository {
  final SignUpRemoteDataSource signUpRemoteDataSource;
  final SignUpLocalDataSource signUpLocalDataSource;

  SignUpRepoImpl({
    required this.signUpRemoteDataSource,
    required this.signUpLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> registerSeller(
      SignUpEntity signUpEntity) async {
    try {
      await signUpRemoteDataSource
          .register(SignUpBodyModel.fromEntity(signUpEntity));
      return right("Seller Account Created");
    } catch (error) {
      return left(error as Failure);
    }
  }

  @override
  Future<Either<Failure, String>> saveRegisterInfo(
      SignUpBodyModel registerState) async {
    try {
      await signUpLocalDataSource.saveRegisterInfo(registerState);
      return right("Info Saved");
    } catch (error) {
      // Ensure the error is properly converted to a Failure object
      if (error is Failure) {
        return left(error);
      } else {
        // Convert the error to a custom Failure if it's not already a Failure
        return left(ServerFailure(message: error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SignUpBodyModel>> getRegisterInfo() async {
    var res = await signUpLocalDataSource.getRegisterInfo();
    return right(res);
  }

  @override
  Future<Either<Failure, bool>> checkRecaptchaToken(
      String recaptchaToken) async {
    try {
      var res = await signUpRemoteDataSource.checkRecaptchaToken(recaptchaToken);
      return right(res);
    } catch (error) {
      return left(error as Failure);
    }
  }
}
