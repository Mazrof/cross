import 'package:dartz/dartz.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import '../model/login_request_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<Unit> login({required LoginRequestBody loginModel});
}

class LoginRemoteDataSource implements BaseLoginRemoteDataSource {
  final ApiService _apiService;

  LoginRemoteDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<Unit> login({required LoginRequestBody loginModel}) async {
    print('LoginRemoteDataSource: login: email: ${loginModel.email}');

    final response = await _apiService.post(
      endPoint: 'api/login',
      data: {
        "userName": loginModel.email,
        "password": loginModel.password,
        "verified": true,
        "blocked": false,
        "delay": 20
      },
    );
    UserAccessToken.accessToken = response.data['userDetails']['session'];
    if(loginModel.rememberMe ?? false)
    {
      await CacheHelper.write(
        key: AppStrings.token,
        value: UserAccessToken.accessToken,
      );
    }
 
    print('here');
    print(response.data);
    print(UserAccessToken.accessToken);

    return Future.value(unit);
  }
}
