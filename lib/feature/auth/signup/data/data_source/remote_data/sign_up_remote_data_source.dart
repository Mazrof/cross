import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpRemoteDataSource {
  Future<void> register(SignUpBodyModel signUpBodyModel);
  Future<bool> checkRecaptchaToken(String recaptchaToken);
}

class SignUpRemoteDataSourceImp extends SignUpRemoteDataSource {
  final ApiService apiService = sl<ApiService>();

  @override
  Future<void> register(SignUpBodyModel signUpBodyModel) async {
    String target = ApiConstants.register;
    print('going to register');

    var response = await apiService.post(
      endPoint: target,
      data: signUpBodyModel.toJson(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final cookies = await apiService.cookieJar
          .loadForRequest(Uri.parse('${ApiService.baseUrl}auth/signup'));

      print('Cookies: $cookies');
      print('register success');
    } else {
      throw ServerFailure(message: 'Failed to register');
    }
  }

  @override
  Future<bool> checkRecaptchaToken(String recaptchaToken) async {
    print('here to check recaptcha token');
    print('recaptchaToken: $recaptchaToken');
    return apiService.verifyToken(recaptchaToken);
  }
}
