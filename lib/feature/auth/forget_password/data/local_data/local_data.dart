// import 'package:telegram/core/local/cache_helper.dart';
// import 'package:telegram/core/utililes/app_strings/app_strings.dart';

// abstract class ForgetPasswordLocalDataSource {
//   Future<void> saveToken(String token);
//   Future<String> getToken();
// }

// class ForgetPasswordLocalDataSourceImpl implements ForgetPasswordLocalDataSource {
  

//   ForgetPasswordLocalDataSourceImpl();

//   @override
//   Future<String> getToken() async {
//     return  await CacheHelper.read('token');
//   }

//   @override
//   Future<void> saveToken(String token) async {
//     await  CacheHelper.write(AppStrings.token, key: 'token', value: token);
//   }
// }
