import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/data/model/register_data.dart';
import '../../error/faliure.dart';

class ApiService {
  final PersistCookieJar cookieJar;
  static const String baseUrl = "http://10.0.2.2:3000/api/v1";
  static const String endPointPro =
      "https://MAZROF.com/api/v1 - production server";
  static const String mockUrl =
      "https://a5df8922-201a-4775-a00a-1f660e42c3f5.mock.pstmn.io";
  Dio dio;

  // Private named constructor
  ApiService._internal(this.cookieJar, this.dio);

  // Factory constructor to create an instance of ApiService asynchronously
  static Future<ApiService> create() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path));
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
    ));
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          await ApiService._internal(cookieJar, dio).howAmI();
          // Retry the original request
          final options = error.requestOptions;
          final response = await dio.request(
            options.path,
            options: Options(
              method: options.method,
              headers: options.headers,
            ),
            data: options.data,
            queryParameters: options.queryParameters,
          );
          return handler.resolve(response);
        }
        return handler.next(error);
      },
    ));
    return ApiService._internal(cookieJar, dio);
  }

  Future<void> howAmI() async {
    var endp = 'auth/whoami';
    final whoAmIResponse = await dio.get(endp);
    print('Who Am I Response: ${whoAmIResponse.data}');
    if (whoAmIResponse.statusCode == 201 || whoAmIResponse.statusCode == 200) {
      // Get user data and store it
      var userData = whoAmIResponse.data['data']['user'];
      var user = RegisterData.fromJson(userData);
      for (var key in user.toJson().keys) {
        print('key: $key');
        HiveCash.write(
          boxName: 'register_info',
          key: key,
          value: user.toJson()[key],
        );
      }
    }
  }

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _loadCookies();
      Response response = await dio.get(
        '$baseUrl/$endPoint',
        queryParameters: queryParameters,
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
  }) async {
    try {
      await _loadCookies();
      String url = '$baseUrl/$endPoint';
      final response = await dio.post(url, data: data);
      print(response.data);
      print(response.statusCode);
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
    Map<String, dynamic>? body,
  }) async {
    try {
      await _loadCookies();
      Response response = await dio.put(
        '$baseUrl/$endPoint',
        data: body,
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

  Future<Response> delete({
    required String endPoint,
  }) async {
    try {
      await _loadCookies();
      Response response = await dio.delete(
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

  Future<Response> patch({
    required String endPoint,
    Object? data,
  }) async {
    try {
      await _loadCookies();
      Response response = await dio.patch(
        '$baseUrl/$endPoint',
        data: data,
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
      await _loadCookies();
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

  Future<void> _loadCookies() async {
    final cookies = await cookieJar.loadForRequest(Uri.parse(baseUrl));
    print('Loaded cookies: $cookies');
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
