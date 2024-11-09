import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/login/domain/repositories/base_repo.dart';
import 'package:telegram/feature/auth/login/data/model/login_request_model.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, void>> call(LoginRequestBody loginModel) async {
    try {
      return await loginRepository.login(loginModel);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
