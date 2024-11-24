import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/dashboard/data/data_source/remote_data_source/dashboard_data_source.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class DashboardRemoteRepoImpl implements DashboardRepo {
  final DashboardDataSource dataSource;

  DashboardRemoteRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure,  List<UserModel>>> getUsers() async {
    try {
      final response = await dataSource.getUsers();
      final List<UserModel> users = (response.data as List).map((user) => UserModel.fromJson(user)).toList();
      return Right(users);
      
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
  Future<Either<Failure,  List<GroupModel>>> getGroups() async {
    try {
    final response = await dataSource.getGroups();
    final List<GroupModel> groups = (response.data as List).map((group) => GroupModel.fromJson(group)).toList();
    return Right(groups);
      
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
