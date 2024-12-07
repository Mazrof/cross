import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';

class RegisterUseCase extends BaseUseCase<void, SignUpBodyModel> {
  final SignUpRepository signUpRepo;

  RegisterUseCase(this.signUpRepo);

  @override
  Future<Either<Failure, void>> call(SignUpBodyModel parameter) async {
    try {
      await signUpRepo.register(parameter);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
