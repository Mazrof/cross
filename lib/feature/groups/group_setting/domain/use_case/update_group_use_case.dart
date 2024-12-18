import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class UpdateGroupDetailsUseCase {
  final GroupSettingRepository _groupRepository;

  UpdateGroupDetailsUseCase(this._groupRepository);
  Future<void> call(int groupId, GroupUpdateData data) async {
    return _groupRepository.updateGroupDetails(groupId, data);
  }
}
