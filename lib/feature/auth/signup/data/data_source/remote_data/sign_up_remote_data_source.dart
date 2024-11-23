import 'package:dio/dio.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpRemoteDataSource {
  Future<Response> register(SignUpBodyModel signUpBodyModel);
  Future<bool> checkRecaptchaToken(String recaptchaToken);
}

class SignUpRemoteDataSourceImp extends SignUpRemoteDataSource {
  final ApiService apiService;

  SignUpRemoteDataSourceImp({required this.apiService}) {
    _setupDio();
  }
  _setupDio() {
    apiService.dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  @override
  Future<Response> register(SignUpBodyModel signUpBodyModel) async {
    String target = ApiConstants.register;
    var response = await apiService.post(
      endPoint: target,
      data: signUpBodyModel.toJson(),
    );

    return response;
  }

  @override
  Future<bool> checkRecaptchaToken(String recaptchaToken) async {
    print('here to check recaptcha token');
    print('recaptchaToken: $recaptchaToken');
    return apiService.verifyToken(recaptchaToken);
  }
}
