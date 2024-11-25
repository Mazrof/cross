import 'package:telegram/feature/dashboard/data/data_source/local_data_source/dashboard_data_source.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class DashboardLocalRepoImpl implements DashboardLocalRepo {
  final DashboardLocalDataSource localDataSource;

  DashboardLocalRepoImpl({required this.localDataSource});

  @override
  Future<List<UserModel>> getUsers() async {
    return await localDataSource.getUsers();
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    return await localDataSource.getGroups();
  }

  @override
  Future<void> saveUsers(List<UserModel> users) async {
    await localDataSource.saveUsers(users);
  }

  @override
  Future<void> saveGroups(List<GroupModel> groups) async {
    await localDataSource.saveGroups(groups);
  }
}
