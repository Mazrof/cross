import 'package:dartz/dartz.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/api/api_service.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> resetPassword(String token, String newPassword);
}

class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  ForgetPasswordRemoteDataSourceImpl();
  final ApiService apiService = sl<ApiService>();

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    String endpoint = '';
    try {
      final response = await apiService.post(
        endPoint: '',
        data: {'email': email},
      );
      // Assuming a successful response returns an empty right value
      return Right(null);
    } catch (error) {
      // Handle error and return a Failure
      return Left(error as Failure);
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      String token, String newPassword) async {
    try {
      final response = await apiService.post(
        endPoint: '',
        data: {'token': token, 'newPassword': newPassword},
      );
      // Assuming a successful response returns an empty right value
      return Right(null);
    } catch (error) {
      // Handle error and return a Failure
      return Left(error as Failure);
    }
  }
}
