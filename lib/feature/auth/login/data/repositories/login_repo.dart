import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../../../../../core/error/faliure.dart';
import '../../domain/repositories/base_repo.dart';
import '../model/login_request_model.dart';
import '../data_source/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> login(
      {required LoginRequestBody loginModel}) async {
    await loginRemoteDataSource.login(loginModel: loginModel);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      return Right(await loginRemoteDataSource.signInWithGoogle());
    } catch (e) {
      return Left(ServerFailure(message: e as String));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithGithub(BuildContext context) async {
    try {
      return Right(await loginRemoteDataSource.signInWithGithub(context));
    } catch (e) {
      return Left(ServerFailure(message: e as String));
    }
  }
}
