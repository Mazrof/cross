import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class FetchGroupDetailsUseCase {
  final GroupSettingRepository repository;

  FetchGroupDetailsUseCase(this.repository);
  Future<GroupModel> call(int groupId) async {
    final group = await repository.fetchGroupDetails(groupId);
    return group;
  }
}
