import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';


abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class DataBaseFailure extends Failure {
  const DataBaseFailure({required super.message});
}

class ServerFailure extends Failure {


  const ServerFailure( {required super.message});
  factory ServerFailure.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(message: AppStrings.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: AppStrings.connectionTimeout);
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: AppStrings.connectionTimeout);
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: AppStrings.badCertification);
      case DioExceptionType.badResponse:
        return ServerFailure.fromDioResponse(
          error.response!.statusCode!,
          error.response,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(message: AppStrings.requestCancelled);
      case DioExceptionType.connectionError:
        {
          return const ServerFailure(message: AppStrings.errorNetwork);
        }
      case DioExceptionType.unknown:
        return const ServerFailure(
          message: AppStrings.errorUnknown,
        );
    }
  }
  factory ServerFailure.fromDioResponse(int statusCode, dynamic response) {
    if (statusCode == 404 || statusCode == 400) {
      return const ServerFailure(
        message: AppStrings.badResponseMessage,
      );
    } else if (statusCode == 500) {
      return const ServerFailure(
        message: AppStrings.errorInternal,
      );
    } else if (statusCode == 401) {
      return const ServerFailure(
         message: AppStrings.errorUnauthorized,
      );
    }
    return const ServerFailure(message: AppStrings.badResponseMessage);
  }
}
