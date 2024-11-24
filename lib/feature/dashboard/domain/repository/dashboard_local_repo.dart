
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';

abstract class DashboardLocalRepo {
  Future<List<UserModel>> getUsers();
  Future<List<GroupModel>> getGroups();
  Future<void> saveUsers(List<UserModel> users);
  Future<void> saveGroups(List<GroupModel> groups);
}
