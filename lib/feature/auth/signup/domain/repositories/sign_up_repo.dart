import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';

abstract class SignUpRepository {
  Future<Either<Failure, String>> register(SignUpEntity signUpEntity);
  Future<Either<Failure, String>> saveRegisterInfo(
      SignUpBodyModel registerState);
  Future<Either<Failure, SignUpBodyModel?>> getRegisterInfo();
  Future<Either<Failure, bool>> checkRecaptchaToken(String recaptchaToken);
}
