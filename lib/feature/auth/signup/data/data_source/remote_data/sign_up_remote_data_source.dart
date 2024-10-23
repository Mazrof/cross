import 'package:dio/dio.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpRemoteDataSource {
  Future<Map<String, dynamic>> sendOtp(String email);
  Future<Map<String, dynamic>> verifyOtp(String email, String otpCode);
  Future<Response> register(SignUpBodyModel signUpBodyModel);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  final ApiService apiService;

  SignUpRemoteDataSourceImpl({required this.apiService}) {
    _setupDio();
  }
  _setupDio() {
    apiService.dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  @override
  Future<Map<String, dynamic>> sendOtp(String email) async {
    String target = ApiConstants.sendOtp;
    final Map<String, String> requestBody = {
      'input': email,
      'provider': 'EMAIL'
    };
    var response = await apiService.post(endPoint: target, data: requestBody);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String email, String otpCode) async {
    String target = ApiConstants.verifyOtp;
    final Map<String, String> requestBody = {
      'otp': otpCode,
      'input': email,
      'provider': 'EMAIL'
    };
    var response = await apiService.post(endPoint: target, data: requestBody);

    return response.data;
  }

  @override
  Future<Response> register(SignUpBodyModel signUpBodyModel) async {
    String target = ApiConstants.register;
    var response = await apiService.post(
      endPoint: target,
      data: signUpBodyModel.toJson(),
    );
   
    UserAccessToken.accessToken = response.data.data!.token!.accessToken;
    await CacheHelper.write(
      key: AppStrings.token,
      value: UserAccessToken.accessToken,
    );
    return response;
  }
}
