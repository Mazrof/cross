import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';

class ApplyFilterUseCase {
  final DashboardRepo repository;

  ApplyFilterUseCase(this.repository);

  Future<Either<Failure, bool>> call(String recaptchaToken) async {
    return await repository.applyFilter(recaptchaToken);
  }
}
