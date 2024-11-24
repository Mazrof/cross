import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class UnBanUserUseCase {
  final DashboardRepo repository;

  UnBanUserUseCase(this.repository);

  Future<Either<Failure, bool>> call( String userID) async {
    return await repository.unBanUser(userID);
  }
}
