import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';

abstract class VerifyMailDataSource {
  Future<Either<Failure, void>> sendOtp(String method, String email);
  Future<Either<Failure, bool>> verifyOtp(VerifyMailData data);
}

class VerifyMailDataSourceImp extends VerifyMailDataSource {
  ApiService apiService = sl<ApiService>();
  @override
  Future<Either<Failure, void>> sendOtp(String method, String email) async {
    print('method: $method');
    if (method == 'email') {
      final Map<String, String> requestBody = {
        'email': email,
      };
      try {
        await apiService.post(
            endPoint: ApiConstants.sendOtpMial, data: requestBody);
        return Right(null);
      } catch (e) {
        return Left(e as Failure);
      }
    } else {
      final Map<String, String> requestBody = {
        'phoneNumber': email,
      };
      try {
        print('requestBody: $requestBody');
        final res = await apiService.post(
            endPoint: ApiConstants.sendOtpPhone, data: requestBody);

        print(res.data);
        return Right(null);
      } catch (e) {
        return Left(e as Failure);
      }
    }
  }

  Future<Either<Failure, bool>> verifyOtp(VerifyMailData data) async {
    String target = ApiConstants.verifyOtp;
    Map<String, String> requestBody;
    if (data.method == 'email') {
      requestBody = {
        'code': data.code,
        'email': data.email,
      };
    } else {
      requestBody = {
        'code': data.code,
        'phoneNumber': data.email,
      };
    }
    print('requestBody: $requestBody');

    try {
      Response response =
          await apiService.post(endPoint: target, data: requestBody);
      return response.statusCode == 200 ? Right(true) : Right(false);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
