import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class GetUsersUseCase {
  final DashboardLocalRepo repository;

  GetUsersUseCase(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
