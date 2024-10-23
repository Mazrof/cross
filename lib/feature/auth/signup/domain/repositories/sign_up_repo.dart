import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_state.dart';

abstract class SignUpRepo {
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(String email);
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      String email, String otpCode);
  Future<Either<Failure, String>> registerSeller(SignUpEntity signUpEntity);
  Future<Either<Failure, String>> saveRegisterInfo(
      SignUpBodyModel registerState);
  Future<Either<Failure, SignUpBodyModel?>> getRegisterInfo();
}
