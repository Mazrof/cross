import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';

class RegisterUseCase extends BaseUseCase<String, SignUpBodyModel> {
  final SignUpRepository signUpRepo;

  RegisterUseCase(this.signUpRepo);

  @override
  Future<Either<Failure, String>> call(SignUpBodyModel parameter) async {
    try {
      final response = await signUpRepo.register(parameter);
      return response;
    } catch (error) {
      return left(ServerFailure(message: error.toString()));
    }
  }
}
