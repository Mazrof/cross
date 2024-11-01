// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_state.dart';

class GetRegisterInfoUseCase
    extends BaseUseCase<SignUpBodyModel?, NoParameters> {
  SignUpRepository signUpRepo;
  GetRegisterInfoUseCase(
    this.signUpRepo,
  );

  @override
  Future<Either<Failure, SignUpBodyModel?>> call(NoParameters parameter) async {
    try {
      var res = signUpRepo.getRegisterInfo();
      return res;
    } catch (error) {
      return Left(error as Failure);
    }
  }
}
