import 'dart:convert';

import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpLocalDataSource {
  Future<void> saveRegisterInfo(SignUpBodyModel registerState);
  Future<SignUpBodyModel> getRegisterInfo();
}

class SignUpLocalDataSourceImpl extends SignUpLocalDataSource {
  final String registerInfoKey = "register_info";
  @override
  Future<SignUpBodyModel> getRegisterInfo() async {
    final registerInfoString = await CacheHelper.read(key: registerInfoKey);
    // print(registerInfoString);
    if (registerInfoString != null) {
      return SignUpBodyModel.fromEntity(jsonDecode(registerInfoString));
    } else {
      return SignUpBodyModel.empty();
    }
  }

  @override
  Future<void> saveRegisterInfo(SignUpBodyModel registerState) async {
    await CacheHelper.write(
        key: registerInfoKey, value: registerState.toJson());
  }
}
