import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:dio/dio.dart';
import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class GetUsersUseCase {
  final DashboardRepo repository;

  GetUsersUseCase(this.repository);

  Future<Either<Failure, List<UserModel>>> call() async {
    return await repository.getUsers();
  }
}
