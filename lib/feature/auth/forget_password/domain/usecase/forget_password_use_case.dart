
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordUseCase {
  final ForgetPasswordRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<void> execute(String email) {
    return repository.forgetPassword(email);
  }
}
