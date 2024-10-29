import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';

class ResetPasswordUseCase {
  final ForgetPasswordRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> execute(String token, String newPassword) {
    return repository.resetPassword(token, newPassword);
  }
}
