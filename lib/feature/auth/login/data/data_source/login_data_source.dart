import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
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
        // Extract the access token and refresh token from the response
        int id = response.data['data']['user']['id'];
        String userType = response.data['data']['user']['user_type'];

        // Store the access token and refresh token in the cache
        if (loginModel.rememberMe == true) {
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
        // var endp = 'auth/whoami';
        // final whoAmIResponse = await _apiService.get(
        //   endPoint: endp,
        // );
        // print('Who Am I Response: ${whoAmIResponse.data}');
        // if (whoAmIResponse.statusCode == 201 ||
        //     whoAmIResponse.statusCode == 200) {
        //   print('Who Am I Response: ${whoAmIResponse.data}');
        //   // HiveCash.write(boxName: 'register_info', key: 'user', value: whoAmIResponse.data['data']);
        // }

        return response.statusCode == 201 || response.statusCode == 200;
      }

      return false;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to login');
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? user = await googleSignIn.signIn();

    if (user != null) {
      GoogleSignInAuthentication auth = await user.authentication;
      String? accessToken = auth.accessToken;

      print(accessToken);

      //////////////////////////////////////////////////////////////
      ///  Uncomment that code when the endpoint is available /////
      ///////////////////////////////////////////////////////////

      // final response = await apiService.post(
      //   endPoint: 'verify-token',
      //   data: {'token': accessToken},
      // );

      // print(response.statusCode);
      // print(response.data);

      // if (response.statusCode != 200) {
      //   throw Exception('Google login failed');
      // }

      return accessToken!;
    }

    return "";
  }

  @override
  Future<String> signInWithGithub(BuildContext context) async {
    print('Github login started');

    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: 'Ov23liNhZ8W3afDrCcjO',
      clientSecret: '14df323aed985c282ea8eeef2612579434dd3eb8',
      redirectUrl:
          'https://telegram-clone-a4785.firebaseapp.com/__/auth/handler',
      title: 'GitHub Connection',
      centerTitle: false,
    );

    var result = await gitHubSignIn.signIn(context);

    if (result.status == GitHubSignInResultStatus.ok) {
      print(result.token);

      return result.token!;

      //////////////////////////////////////////////////////////////
      ///  Uncomment that code when the endpoint is available /////
      ///////////////////////////////////////////////////////////

      // final response = await apiService.post(
      //   endPoint: 'verify-token',
      //   data: {'token': accessToken},
      // );

      // print(response.statusCode);
      // print(response.data);

      // if (response.statusCode != 200) {
      //   throw Exception('Github login failed');
      // }
    } else {
      print(result.errorMessage);
    }

    return "";
  }
}
