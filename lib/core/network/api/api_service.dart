import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../../error/faliure.dart';

class ApiService {
  static const String baseUrl = mockUrl;
  static const String endPointPro =
      "https://MAZROF.com/api/v1 - production server";
  static const String endPointDev =
      "https://virtserver.swaggerhub.com/ABDOMOHAMED9192_1/Mazrof-API/1.0.0 - SwaggerHub API Auto Mocking";

  static const String mockUrl =
      "https://a5df8922-201a-4775-a00a-1f660e42c3f5.mock.pstmn.io";
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',
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
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

      Response response = await dio.get(
        '$baseUrl/$endPoint',
      );
      print(response.data);
      print(response.statusCode);

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

  Future<Response> post({
    required String endPoint,
    Object? data,
    String? token,
  }) async {
    try {
      String url = '$baseUrl/$endPoint';
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw response;
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
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

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
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

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
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

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

  Future<bool> verifyToken(String token) async {
    const String verifyUrl =
        'https://www.google.com/recaptcha/enterprise.js?render=6LcFx2wqAAAAAP1u80FSm2yTVbNi293Vw7JKfIZU';
    const String siteKey = '6LcFx2wqAAAAAP1u80FSm2yTVbNi293Vw7JKfIZU';
    final requestBody = {
      "event": {
        "token": token,
        "expectedAction": "signup",
        "siteKey": siteKey,
      }
    };

    try {
      final response = await Dio().post(
        verifyUrl,
        data: jsonEncode(requestBody),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      final jsonResponse = response.data;
      final isValid = jsonResponse['tokenProperties']['valid'] == true;
      final score = jsonResponse['riskAnalysis']['score'];
      final action = jsonResponse['tokenProperties']['action'];

      print('Verification Score: $score, Action: $action');

      // You can set a threshold score if needed, usually above 0.5
      return isValid && score >= 0.5;
    } catch (e) {
      print('Error verifying reCAPTCHA Enterprise token: $e');
      return false;
    }
  }

  Future<Response> getForSearch({
    required String endPoint,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    try {
      dio.options.headers =
          token == null ? {} : {'Authorization': 'Bearer $token'};

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
