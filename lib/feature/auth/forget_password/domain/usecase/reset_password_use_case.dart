import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ResetPasswordUseCase extends TwoParameters<void, String, String> {
  final ForgetPasswordRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String parameter1, String parameter2) {
    return repository.resetPassword(parameter1, parameter2);
  }
}
