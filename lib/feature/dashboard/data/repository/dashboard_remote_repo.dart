import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/dashboard/data/data_source/remote_data_source/dashboard_data_source.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class DashboardRemoteRepoImpl implements DashboardRepo {
  final DashboardDataSource dataSource;

  DashboardRemoteRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, Response>> getUsers() async {
    try {
      final response = await dataSource.getUsers();
      return Right(response);
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
  Future<Either<Failure, Response>> getGroups() async {
    try {
      final response = await dataSource.getGroups();
      return Right(response);
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
