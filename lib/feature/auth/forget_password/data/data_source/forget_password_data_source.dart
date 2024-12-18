import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_service.dart';

abstract class ForgetPasswordDataSource {
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> resetPassword(String token, String newPassword);
  Future<Either<Failure, void>> logoutFromAllDevices();
}

class ForgetPasswordDataSourceImp implements ForgetPasswordDataSource {
  ForgetPasswordDataSourceImp(this.apiService);
  final ApiService apiService;

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    String endpoint = 'auth/request-password-reset';
    try {
      final response = await apiService.post(
        endPoint: endpoint,
        data: {'email': email},
      );
      // Assuming a successful response returns an empty right value
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure(message: response.data['message']));
      }
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
        endPoint: 'auth/reset-password',
        data: {
          'token': token,
          'newPassword': newPassword,
          'userId': HiveCash.read(boxName: 'register_info', key: 'id')
        },
      );

      // Assuming a successful response returns an empty right value
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure(message: response.data['message']));
      }
    } catch (error) {
      // Handle error and return a Failure
      return Left(error as Failure);
    }
  }

  @override
  Future<Either<Failure, void>> logoutFromAllDevices() async {
    try {
      final response = await apiService.post(
        endPoint: 'auth/logout',
        data: {},
      );
      // Assuming a successful response returns an empty right value
      return Right(null);
    } catch (error) {
      // Handle error and return a Failure
      return Left(error as Failure);
    }
  }
}
