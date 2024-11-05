import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/auth/login/domain/repositories/base_repo.dart';

class LoginWithGithubUseCase implements BaseUseCase<String, BuildContext> {
  final LoginRepository loginRepository;

  LoginWithGithubUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, String>> call(BuildContext context) async {
    try {
      return await loginRepository.signInWithGithub(context);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(e as Failure);
      }
    }
  }
}
