import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';

abstract class SignUpLocalDataSource {
  Future<void> saveRegisterInfo(SignUpBodyModel registerState);
  Future<SignUpBodyModel> getRegisterInfo();
}

class SignUpLocalDataSourceImp extends SignUpLocalDataSource {
  final String registerInfoKey = "register_info";
  @override
  Future<SignUpBodyModel> getRegisterInfo() async {
    print('GetRegisterInfoUseCase called');
    var data;
    try {
      data = await HiveCash.readAll(boxName: 'register_info');
    } catch (e) {
      print('error in getRegisterInfo: $e');
    }
    print('data: $data');
    return SignUpBodyModel.fromJson(data);
  }

  @override
  Future<void> saveRegisterInfo(SignUpBodyModel registerState) async {
    print('SaveRegisterInfoUseCase called');
    await HiveCash.openBox('register_info'); // Open the necessary Hive box
    for (var item in registerState.toJson().entries) {
      await HiveCash.write(
          boxName: 'register_info', key: item.key, value: item.value);
    }

    CacheHelper.write(key: 'registered', value: "true");
  }
}
