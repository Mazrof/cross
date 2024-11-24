import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/error/faliure.dart';

abstract class DashboardRepo {
  Future<Either<Failure, Response>> getUsers();
  Future<Either<Failure, bool>> banUser(String userID);
  Future<Either<Failure, bool>> unBanUser(String UserID);
  Future<Either<Failure, Response>> getGroups();
  Future<Either<Failure, bool>> applyFilter(String groupID);
}
