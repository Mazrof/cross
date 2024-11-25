import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive_helper.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';

abstract class DashboardLocalDataSource {
  Future<List<UserModel>> getUsers();
  Future<List<GroupModel>> getGroups();
  Future<void> saveUsers(List<UserModel> users);
  Future<void> saveGroups(List<GroupModel> groups);
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  DashboardLocalDataSourceImpl();

  @override
  Future<List<UserModel>> getUsers() async {
    await HiveHelper.openBox<UserModel>('userBox'); // Ensure the box is opened

    List<UserModel> list = HiveHelper.getAll<UserModel>('userBox');

    HiveHelper.closeBox('userBox');
    return list;
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    await HiveHelper.openBox<GroupModel>(
        'groupBox'); // Ensure the box is opened
    final result = await HiveHelper.getAll<GroupModel>('groupBox');
    HiveHelper.closeBox('groupBox');
    return result;
  }

  @override
  Future<void> saveUsers(List<UserModel> users) async {
    await HiveHelper.openBox<UserModel>('userBox'); // Ensure the box is opened
    await HiveHelper.clear('userBox');
    for (var user in users) {
      await HiveHelper.write(
          boxName: 'userBox', key: user.id.toString(), value: user);
    }

    HiveHelper.closeBox('userBox');
  }

  @override
  Future<void> saveGroups(List<GroupModel> groups) async {
    await HiveHelper.openBox<GroupModel>(
        'groupBox'); // Ensure the box is opened
    await HiveHelper.clear('groupBox');
    for (var group in groups) {
      await HiveHelper.write(
          boxName: 'groupBox', key: group.id.toString(), value: group);
    }
    HiveHelper.closeBox('groupBox');
  }
}
