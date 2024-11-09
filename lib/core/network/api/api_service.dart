import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../../error/faliure.dart';

class ApiService {
  static const String baseUrl = AppStrings.serverUrl;
  static const String endPointPro = "";
  // static const String endPointDev = "";

  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${UserAccessToken.accessToken}',
      },
      validateStatus: (int? status) {
        return (status ?? 0) < 500;
      },
    ),
  );

  void initialize(String token) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> get({
    required String endPoint,
    String? token,
    bool isUserType = false,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {'Authorization': 'Bearer $token', 'userType': 'seller'};
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response = await dio.get(
        '$baseUrl/$endPoint',
      );
      // Response response = await dio.get(
      //   '$baseUrl/$endPoint?userType=seller',
      // );
      // print(response.data);
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw response;
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        log("i will call handle error in api service");
        throw _handleError(e);
      }
    }
  }

  Future<Response> post({
    required String endPoint,
    Object? data,
    String? token,
    bool isUserType = false,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response = await dio.post(
        '$baseUrl/$endPoint',
        data: data,
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

  Future<Response> put({
    required String endPoint,
    String? token,
    Map<String, dynamic>? body,
    bool isUserType = false,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response = await dio.put(
        '$baseUrl/$endPoint',
        data: body,
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

  Future<Response> delete({
    required String endPoint,
    String? token,
    bool isUserType = false,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response = await dio.delete(
        '$baseUrl/$endPoint',
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

  Future<Response> patch({
    required String endPoint,
    String? token,
    Object? data,
    bool isUserType = false,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response = await dio.patch(
        '$baseUrl/$endPoint',
        data: data,
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

  Future<Response> getForSearch({
    required String endPoint,
    String? token,
    bool isUserType = false,
    Map<String, dynamic>? data,
  }) async {
    try {
      dio.options.headers =
          token == null ? {} : {'Authorization': 'Bearer $token'};
      isUserType ? dio.options.headers["userType"] = "seller" : () {};
      Response response =
          await dio.get('$baseUrl/$endPoint', queryParameters: data);
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
