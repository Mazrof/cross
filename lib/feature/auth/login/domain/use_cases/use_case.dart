import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/faliure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../data/model/login_request_model.dart';
import '../repositories/base_repo.dart';

class LoginUseCase implements BaseUseCase<Unit, LoginRequestBody> {
  final BaseLoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, Unit>> call(LoginRequestBody loginModel) async {
    try {
        return await loginRepository.login(loginModel: loginModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(e as Failure);
      }
    }
  }
}
