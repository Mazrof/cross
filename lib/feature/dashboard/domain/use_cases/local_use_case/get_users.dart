import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class GetUsersLocalUseCase {
  final DashboardLocalRepo repository;

  GetUsersLocalUseCase(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
