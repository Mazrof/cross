import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../../error/faliure.dart';

class ApiService {
  final CookieJar cookieJar;
  static const String baseUrl = "http://192.168.100.3:3000/api/v1";
  static const String endPointPro =
      "https://MAZROF.com/api/v1 - production server";
  static const String mockUrl =
      "https://a5df8922-201a-4775-a00a-1f660e42c3f5.mock.pstmn.io";

  Dio dio;

  ApiService()
      : cookieJar = PersistCookieJar(storage: FileStorage('./cookies')),
        dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (int? status) {
            return (status ?? 0) < 500;
          },
        )) {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$endPoint',
        queryParameters: queryParameters,
      );

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ServerFailure(message: response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<Response> post({
    required String endPoint,
    Object? data,
  }) async {
    try {
      String url = '$baseUrl/$endPoint';
      final response = await dio.post(url, data: data);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw ServerFailure(message: response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw ServerFailure(message: e.toString());
      }
    }
  }

  Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response response = await dio.put(
        '$baseUrl/$endPoint',
        data: body,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ServerFailure(message: response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<Response> delete({
    required String endPoint,
  }) async {
    try {
      Response response = await dio.delete(
        '$baseUrl/$endPoint',
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ServerFailure(message: response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<Response> patch({
    required String endPoint,
    Object? data,
  }) async {
    try {
      Response response = await dio.patch(
        '$baseUrl/$endPoint',
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ServerFailure(message: response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<bool> verifyToken(String token) async {
    final String secretKey = '6LfFCIsqAAAAAD_X_EIbKtkmf6WElq4XKqLVrANB';
    final String verifyUrl = 'https://www.google.com/recaptcha/api/siteverify';

    try {
      final response = await Dio().post(
        verifyUrl,
        data: {
          'secret': secretKey,
          'response': token,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = response.data;
        print('reCAPTCHA Response: $result');

        final isValid = result['success'] ?? false;
        final score = result['score'] ?? 0.0;

        // Ensure score meets threshold (e.g., 0.5 for human-like interaction)
        return isValid && score >= 0.5;
      }
      return false;
    } catch (e) {
      print('Error verifying token: $e');
      return false;
    }
  }

  Future<Response> getForSearch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$endPoint',
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw response;
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<Response> sendFCMToken(String token) async {
    const String target = 'users/fcm-token';
    final Map<String, String> body = {
      'fcm_token': token,
    };
    final response = await dio.post('$baseUrl/$target', data: body);
    return response;
  }

  static Exception _handleError(dynamic e) {
    if (e.data != null) {
      final response = e.data;
      switch (e.statusCode) {
        case 400:
          throw ServerFailure(message: response['message'] ?? 'Bad request');
        case 401:
          throw const ServerFailure(message: AppStrings.errorUnauthorized);
        case 403:
          throw const ServerFailure(message: AppStrings.errorForbidden);
        case 404:
          throw ServerFailure(
              message: response['message'] ?? AppStrings.errorResource);
        case 429:
          throw const ServerFailure(message: AppStrings.errorServer);
        case 500:
          throw const ServerFailure(message: AppStrings.errorInternal);
        default:
          throw ServerFailure(
              message:
                  'Server error: ${e.response!.statusCode} ${e.response!.statusMessage}');
      }
    } else {
      throw const ServerFailure(message: AppStrings.errorNetwork);
    }
  }
}
