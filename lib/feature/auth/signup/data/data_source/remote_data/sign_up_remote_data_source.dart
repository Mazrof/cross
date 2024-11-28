import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpRemoteDataSource {
  Future<Response> register(SignUpBodyModel signUpBodyModel);
  Future<bool> checkRecaptchaToken(String recaptchaToken);
}

class SignUpRemoteDataSourceImp extends SignUpRemoteDataSource {
  final ApiService apiService = sl<ApiService>();

  @override
  Future<Response> register(SignUpBodyModel signUpBodyModel) async {
    String target = ApiConstants.register;
    print('going to register');

    var response = await apiService.post(
      endPoint: target,
      data: signUpBodyModel.toJson(),
    );

    return response.data['user']['id'];
  }

  @override
  Future<bool> checkRecaptchaToken(String recaptchaToken) async {
    print('here to check recaptcha token');
    print('recaptchaToken: $recaptchaToken');
    return apiService.verifyToken(recaptchaToken);
  }
}
