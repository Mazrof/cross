import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:dio/dio.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class GetUsersUseCase {
  final DashboardRepo repository;

  GetUsersUseCase(this.repository);

  Future<Either<Failure, Response>> call() async {
    return await repository.getUsers();
  }
}
