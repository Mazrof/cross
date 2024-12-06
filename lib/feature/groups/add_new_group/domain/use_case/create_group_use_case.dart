import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/repository/create_group_repo.dart';

class CreateGroupUseCase {
  final CreateGroupRepository repository;

  CreateGroupUseCase(this.repository);

  Future<GroupsModel> call(GroupsModel group) async {
    return repository.createGroup(group);
  }
}
