

import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class LogOutUseCase extends NoParameter<void> {
  final ForgetPasswordRepository repository;

  LogOutUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call() {
    return repository.logoutFromAllDevices();
  }

  
}
