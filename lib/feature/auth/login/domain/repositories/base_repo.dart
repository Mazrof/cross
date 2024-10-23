import 'package:dartz/dartz.dart';
import 'package:telegram/feature/auth/login/data/model/login_request_model.dart';

import '../../../../../core/error/faliure.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, Unit>> login({required LoginRequestBody loginModel});
}
