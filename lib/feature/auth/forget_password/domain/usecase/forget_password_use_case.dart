
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordUseCase extends OneParameter<void, String> {
  final ForgetPasswordRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String param) {
    return repository.forgetPassword(param);
  }
}
