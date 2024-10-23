import 'package:dartz/dartz.dart';
import '../../../../../core/error/faliure.dart';
import '../../domain/repositories/base_repo.dart';
import '../model/login_request_model.dart';
import '../remote_data/remote_data_source.dart';

class LoginRepositoryImpl implements BaseLoginRepository {
  final BaseLoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> login(
      {required LoginRequestBody loginModel}) async {
    await loginRemoteDataSource.login(loginModel: loginModel);
    return const Right(unit);
  }
}
