// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';

class CheckRecaptchaTocken
    extends OneParameter<bool,String> {
  SignUpRepository signUpRepo;
  CheckRecaptchaTocken(
    this.signUpRepo,
  );

  @override
  Future<Either<Failure, bool>> call(String recaptchaToken) async {

    return signUpRepo.checkRecaptchaToken(recaptchaToken);
  }
}
