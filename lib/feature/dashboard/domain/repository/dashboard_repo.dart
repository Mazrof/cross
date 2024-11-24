import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';

abstract class DashboardRepo {
  Future<Either<Failure,  List<UserModel>>> getUsers();
  Future<Either<Failure, bool>> banUser(String userID);
  Future<Either<Failure, bool>> unBanUser(String UserID);
  Future<Either<Failure,  List<GroupModel>>> getGroups();
  Future<Either<Failure, bool>> applyFilter(String groupID);
}
