import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telegram/core/error/excpetions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/auth/login/data/model/register_data.dart';
import '../model/login_request_model.dart';

abstract class LoginDataSource {
  Future<bool> login(LoginRequestBody loginModel);
  Future<String> signInWithGoogle();
  Future<String> signInWithGithub(BuildContext context);
}

class LoginDataSourceImp implements LoginDataSource {
  final ApiService _apiService;

  LoginDataSourceImp({
    required ApiService apiService,
  }) : _apiService = apiService;
  @override
  Future<bool> login(LoginRequestBody loginModel) async {
    print('LoginRemoteDataSource: login: email: ${loginModel.email}');
    try {
      final response = await _apiService.post(
        endPoint: ApiConstants.login,
        data: {
          'email': loginModel.email,
          'password': loginModel.password,
        },
      );
      
      print('Login Response: ${response.data}');
      if (response.statusCode == 201 || response.statusCode == 200) {
         final cookies = await _apiService.cookieJar
            .loadForRequest(Uri.parse('${ApiService.baseUrl}/auth/login'));
        print('Cookies: $cookies');

      
        int id = response.data['data']['user']['id'];
        String userType = response.data['data']['user']['user_type'];

        // Store the access token and refresh token in the cache
        if (loginModel.rememberMe == true) {
          CacheHelper.write(key: 'loged', value: 'true');
          HiveCash.write(
            boxName: 'register_info',
            key: 'email',
            value: loginModel.email,
          );
          HiveCash.write(
            boxName: 'register_info',
            key: 'password',
            value: loginModel.password,
          );
        } else {
          HiveCash.write(
            boxName: 'register_info',
            key: 'email',
            value: '',
          );
          HiveCash.write(
            boxName: 'register_info',
            key: 'password',
            value: '',
          );
          //cash the email and password
        }
        HiveCash.write(
          boxName: 'register_info',
          key: 'id',
          value: id,
        );
        HiveCash.write(
          boxName: 'register_info',
          key: 'user_type',
          value: userType,
        );
        howAmI();

        return response.statusCode == 201 || response.statusCode == 200;
      }

      return false;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to login');
    }
  }

  Future<void> howAmI() async {
    var endp = 'auth/whoami';
    final whoAmIResponse = await _apiService.get(
      endPoint: endp,
    );
    print('Who Am I Response: ${whoAmIResponse.data}');
    if (whoAmIResponse.statusCode == 201 || whoAmIResponse.statusCode == 200) {
      // Get user data and store it
      var userData = whoAmIResponse.data['data']['user'];
      var user = RegisterData.fromJson(userData);
      var userJson = jsonEncode(user.toJson());
      HiveCash.write(
        boxName: 'register_info',
        key: 'user',
        value: userJson,
      );
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? user = await googleSignIn.signIn();
      print('user: $user');

      if (user != null) {
        GoogleSignInAuthentication auth = await user.authentication;
        String? accessToken = auth.accessToken;
        print('accessToken: $accessToken');

        if (accessToken == null) {
          throw Exception('Google login failed: Access token is null');
        }

        // Send the token to the backend for verification
        final response = await _apiService.post(
          endPoint: ApiConstants.GoogleSignIn,
          data: {'token': accessToken},
        );
        print('in google login');
        print(response.data);

        if (response.statusCode == 200) {
          String? backendToken = response.data['data']['token'];
          return backendToken!;
        } else {
          throw Exception('Google login failed: ${response.data['message']}');
        }
      } else {
        throw Exception('Google login cancelled by user');
      }
    } catch (e) {
      print('Google login failed: $e');
      throw Exception('Google login failed');
    }
  }

  @override
  Future<String> signInWithGithub(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: ApiConstants.githubClientId,
        clientSecret: ApiConstants.githubClientSecret,
        redirectUrl: 'http://localhost:5000/github/callback',
        title: 'GitHub Connection',
        centerTitle: false,
      );

      var result = await gitHubSignIn.signIn(context);

      if (result.status == GitHubSignInResultStatus.ok) {
        String? accessToken = result.token;

        if (accessToken == null) {
          throw Exception('GitHub login failed: Access token is null');
        }

        // Send the token to the backend for verification
        final response = await _apiService.post(
          endPoint: ApiConstants.GithubSignIn,
          data: {'token': accessToken},
        );
        print('in github login');
        print(response.data);

        if (response.statusCode == 200) {
          String? backendToken = response.data['data']['token'];
          // HiveCash.write(
          //   boxName: 'register_info',
          //   key: 'accessToken',
          //   value: backendToken,
          // );
          return backendToken!;
        } else {
          throw Exception('GitHub login failed: ${response.data['message']}');
        }
      }

      return "";
    } catch (e) {
      print('Github login failed: $e');
      throw Exception('GitHub login failed');
    }
  }
}
