import 'package:dartz/dartz.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/dashboard/data/data_source/remote_data_source/dashboard_data_source.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class DashboardRemoteRepoImpl implements DashboardRepo {
  final DashboardDataSource dataSource;

  DashboardRemoteRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      bool val = await sl<NetworkManager>().isConnected();
      if (!val) {
        final data = HiveCash.read(boxName: "users_dash", key: "users_dash")
            as List<dynamic>?;

        if (data == null) {
          return Right([]);
        }
        List<UserModel> users = data
            .map((json) => UserModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();

        return Right(users);
      } else {
        final users = await dataSource.getUsers();
        HiveCash.openBox('users_dash');
        HiveCash.write(
            boxName: "users_dash",
            key: "users_dash",
            value: users.map((e) => e.toJson()).toList());
        return Right(users);
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> banUser(String userID) async {
    try {
      final result = await dataSource.banUser(userID);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> unBanUser(String userID) async {
    try {
      final result = await dataSource.unBanUser(userID);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getGroups() async {
    try {
      bool val = await sl<NetworkManager>().isConnected();
      if (!val) {
        final data = HiveCash.read(boxName: "groups_dash", key: "groups_dash")
            as List<dynamic>?;

        if (data == null) {
          return Right([]);
        }
        List<GroupModel> groups = data
            .map((json) => GroupModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();

        return Right(groups);
      } else {
        final groups = await dataSource.getGroups();
        HiveCash.openBox('groups_dash');
        HiveCash.write(
            boxName: "groups_dash",
            key: "groups_dash",
            value: groups.map((e) => e.toJson()).toList());
        return Right(groups);
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> applyFilter(String groupID) async {
    try {
      final result = await dataSource.applyFilter(groupID);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
