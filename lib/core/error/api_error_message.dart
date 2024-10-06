import 'package:dio/dio.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';


class ApiErrorMessage {
  final DioExceptionType type;
  final String title;
  final String message;

  const ApiErrorMessage({
    required this.type,
    required this.title,
    required this.message,
  });

  static List<ApiErrorMessage> errorMessages() => [
        const ApiErrorMessage(
          type: DioExceptionType.connectionError,
          title: AppStrings.connectionError,
          message: AppStrings.connectionErrorMessage,
        ),
        const ApiErrorMessage(
          type: DioExceptionType.connectionTimeout,
          title: AppStrings.connectionTimeout,
          message: AppStrings.connectionTimeoutMessage,
        ),
        const ApiErrorMessage(
          type: DioExceptionType.badResponse,
          title: AppStrings.badResponse,
          message: AppStrings.badResponseMessage,
        ),
        const ApiErrorMessage(
          type: DioExceptionType.cancel,
          title: AppStrings.requestCancelled,
          message: AppStrings.requestCancelled,
        ),
        const ApiErrorMessage(
          type: DioExceptionType.unknown,
          title: AppStrings.errorUnknown,
          message: AppStrings.unknownErrorMessage,
        ),
      ];
}
