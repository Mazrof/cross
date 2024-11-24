import 'package:dartz/dartz.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';

abstract class VerifyMailDataSource {
  Future<Either<Failure, void>> sendOtp(String method ,String email);
  Future<Either<Failure, void>> verifyOtp(VerifyMailData data);
}

class VerifyMailDataSourceImp extends VerifyMailDataSource {
  ApiService apiService = sl<ApiService>();
  @override
  Future<Either<Failure, void>> sendOtp(String method,String email) async {
    String target = ApiConstants.sendOtp;
    final Map<String, String> requestBody = {' ': email, 'provider': method.toUpperCase()};
    try {
      await apiService.post(endPoint: target, data: requestBody);
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(VerifyMailData data) async {
    String target = ApiConstants.verifyOtp;
    final Map<String, String> requestBody = {
      'otp': data.code,
      'input': data.email,
      'provider': data.method.toUpperCase()
    };
    try {
      await apiService.post(endPoint: target, data: requestBody);
      return Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
