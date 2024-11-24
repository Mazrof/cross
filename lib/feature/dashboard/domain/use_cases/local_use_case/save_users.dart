import 'package:telegram/feature/dashboard/data/model/user_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class SaveUsersUseCase {
  final DashboardLocalRepo repository;

  SaveUsersUseCase(this.repository);

  Future<void> call(List<UserModel> users) async {
    return await repository.saveUsers(users);
  }
}
