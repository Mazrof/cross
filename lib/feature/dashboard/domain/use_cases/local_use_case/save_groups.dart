import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart';

class SaveGroupsUseCase {
  final DashboardLocalRepo repository;

  SaveGroupsUseCase(this.repository);

  Future<void> call(List<GroupModel> groups) async {
    return await repository.saveGroups(groups);
  }
}
