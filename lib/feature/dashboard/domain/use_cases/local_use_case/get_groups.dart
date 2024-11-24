
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class GetGroupsUseCase {
  final DashboardLocalRepo repository;

  GetGroupsUseCase(this.repository);

  Future<List<GroupModel>> call() async {
    return await repository.getGroups();
  }
}
